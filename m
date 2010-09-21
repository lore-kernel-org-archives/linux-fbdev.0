From: Jon Nettleton <jon.nettleton@gmail.com>
Date: Tue, 21 Sep 2010 22:18:19 +0000
Subject: Re: [PATCH] viafb: Use proper register for bgcolor when doing MONO blits
Message-Id: <AANLkTin7ZD19NSec58gOCNrbYzeWq5XW4LNte50Nsm8M@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100921154604.2E3059D401B@zog.reactivated.net>
In-Reply-To: <20100921154604.2E3059D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

> #!/bin/sh
>
> echo -e "\033[30;47mblit: BLACK_ON_WHITE\033[0m"
> echo -e "\033[37;40mblit: WHITE_ON_BLACK\033[0m"
> echo -e "\033[31;44mbilt: RED_ON_BLUE\033[0m"
> echo -e "fillrect: YELLOW\033[43m"
> sleep 5
> clear
> echo -e "\033[0m"
> <<<
Ah that is a mono image blit not a mono pattern blit.  then that
register is correct.

Yes that is a bug but nut anything in
> the blitting code but in the VIA_BITBLT_FILL code where I admit that we
> write the colour to the wrong register. Will try to get a proper patch for
> that in the next few days

That code-block should look something like this then.


    if (op != VIA_BITBLT_FILL) {
        writel(fg_color, engine + 0x4C);
        if (op = VIA_BITBLT_MONO)
            writel(bg_color, engine + 0x50);
    } else {
        writel(fg_color, engine + 0x58);
    }

-Jon
