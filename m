From: Jakub Wilk <jwilk@jwilk.net>
Date: Sun, 27 Nov 2016 23:30:01 +0000
Subject: Re: [PATCH v7 0/3] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20161127233001.aan5zndth7fmglhh@jwilk.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161123173340.GA24872@angband.pl>
 <1480265509-20922-1-git-send-email-manuel.schoelling@gmx.de>
 <20161127213730.GO11418@dell-m4800.home>
 <20161127231548.GA29376@angband.pl>
In-Reply-To: <20161127231548.GA29376@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adam Borowski <kilobyte@angband.pl>
Cc: Andrey Utkin <andrey_utkin@fastmail.com>, Manuel =?utf-8?Q?Sch=C3=B6lling?= <manuel.schoelling@gmx.de>, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jslaby@suse.cz, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

* Adam Borowski <kilobyte@angband.pl>, 2016-11-28, 00:15:
>>clear(1) doesn't wipe the scrollback at all, it is still reachable, all of 
>>it.
>
>It does for me on the console.  The man page says:
>
># clear clears your screen if this is possible, including its scrollback
># buffer (if the extended "E3" capability is defined).  clear looks in the
># environment for the terminal type and then in the terminfo database to
># determine how to clear the screen.
>
>Because of its reliance on terminfo, you need to have TERM=linux in your 
>environment; also, screen/tmux obviously breaks this.

The "linux" terminfo entry didn't have E3 until very recently.
You will need ncurses >= 20160514.

-- 
Jakub Wilk
