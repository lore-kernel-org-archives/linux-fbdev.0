From: Jakub Wilk <jwilk@jwilk.net>
Date: Mon, 18 Apr 2016 20:38:37 +0000
Subject: Re: [PATCH 0/2] Persistent scrollback buffers for all VGA consoles
Message-Id: <20160418203837.GA8008@jwilk.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461009418-1795-1-git-send-email-manuel.schoelling@gmx.de>
In-Reply-To: <1461009418-1795-1-git-send-email-manuel.schoelling-Mmb7MZpHnFY@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling-Mmb7MZpHnFY@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, thomas-8tQO0IXuy4gnETEX8uN03g@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, jejb-6jwH94ZQLHl74goWV3ctuw@public.gmane.org, deller-Mmb7MZpHnFY@public.gmane.org, sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

* Manuel Sch=F6lling <manuel.schoelling@gmx.de>, 2016-04-18, 21:56:
>To offer a way for userland tools to flush the buffer my second patch=20
>adds a ioctl call for that.

In f8df13e0a901fe55631fed66562369b4dba40f8b, the escape sequence \e[3J=20
was added, which erases the whole display including the scroll-back=20
buffer. So the new ioctl shouldn't be necessary.

--=20
Jakub Wilk
