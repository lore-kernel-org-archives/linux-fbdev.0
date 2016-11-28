From: Manuel =?ISO-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Date: Mon, 28 Nov 2016 21:28:19 +0000
Subject: Re: [PATCH v7 0/3] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <1480368499.29156.12.camel@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161123173340.GA24872@angband.pl>
         <1480265509-20922-1-git-send-email-manuel.schoelling@gmx.de>
         <20161127213730.GO11418@dell-m4800.home>
In-Reply-To: <20161127213730.GO11418@dell-m4800.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrey Utkin <andrey_utkin@fastmail.com>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jslaby@suse.cz, gregkh@linuxfoundation.org, kilobyte@angband.pl, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Andrey,

Adam already discussed some of your notes, but I want to catch up one
this one:

On So, 2016-11-27 at 21:37 +0000, Andrey Utkin wrote:
> I see the user experience is subpar to what I'm accustomed to (I use
> Konsole and "Clear Scrollback and Reset" action, default shortcut is
> Ctrl+Shift+K). The strange behaviour moments have nothing to do with
> current patchset but are properties of vgacon, though. (I compared it
> with another PC which runs without this patchset, and it looks like it
> runs vgacon, too, however, I'm not sure how to ensure this at runtime.)
I'm not sure what you mean with 'subpar'. Ctrl+Shift+K would probably be
nice - but it might interfere with some shortcuts of programs.
Are you missing any other features?
(I am working on persistent scrollback for framebuffer consoles in the
mean time...)

Bye,

Manuel

