From: Adam Borowski <kilobyte@angband.pl>
Date: Tue, 29 Nov 2016 10:44:20 +0000
Subject: Re: [PATCH v7 0/3] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20161129104420.GA14384@angband.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161123173340.GA24872@angband.pl>
 <1480265509-20922-1-git-send-email-manuel.schoelling@gmx.de>
 <20161127213730.GO11418@dell-m4800.home>
 <1480368499.29156.12.camel@gmx.de>
 <20161129100115.GA20034@stationary.pb.com>
In-Reply-To: <20161129100115.GA20034@stationary.pb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrey Utkin <andrey_utkin@fastmail.com>
Cc: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jslaby@suse.cz, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Nov 29, 2016 at 10:01:15AM +0000, Andrey Utkin wrote:
> Regarding logout scrollback clearing not working for me. ncurses-6.0-rc1
> which I tested it with is the latest available in Gentoo portage, please
> confirm whether I need any newer version, or should I tune something
> else. I'd appreciate if you also tested your patch with gentoo setup.

Could you please check whether its terminfo carries the required
definitions?  In ncurses sources, that's misc/terminfo.src

The relevant parts are:
.--==
# The 3.0 kernel adds support for clearing scrollback buffer (capability E3).
# It is the same as xterm's erase-saved-lines feature.
linux3.0|linux 3.0 kernels,
        E3=\E[3J, use=linux2.6,

# This is Linux console for ncurses.
linux|linux console,
        use=linux3.0,
`----

I believe the first part was added first; if that's true it's possible this
will work for you:
    TERM=linux3.0 clear


I'm not sure what Gentoo does to clear the console during logout: it might
just invoke "clear" (or its underlying ncurses implementation), it might
carry a copy of Debian's "clear_console"[1], it might do something else
entirely.


Meow!

[1]. It originally came from Ubuntu, forked there from "clear".
-- 
The bill declaring Jesus as the King of Poland fails to specify whether
the addition is at the top or end of the list of kings.  What should the
historians do?
