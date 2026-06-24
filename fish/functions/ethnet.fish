function ethnet --description 'Connect to ETH student-net VPN via openconnect, feeding network password + OTP from pass'
    # Prime sudo first so it prompts on the terminal and caches credentials.
    # Otherwise sudo eats the first line of the piped stdin (the network
    # password) as its own auth attempt, leaving openconnect short a password.
    sudo -v; or return

    printf '%s\n%s\n' \
        (pass show online/ethz.ch/radius/jegraf) \
        (pass otp show online/ethz.ch/jegraf_MFE) | \
        sudo openconnect \
            -u jegraf@student-net.ethz.ch \
            --useragent=AnyConnect \
            --no-external-auth \
            --passwd-on-stdin \
            -g student-net \
            sslvpn.ethz.ch $argv
end
