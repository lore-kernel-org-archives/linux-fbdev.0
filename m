From: Andrey Utkin <andrey_utkin@fastmail.com>
Date: Tue, 29 Nov 2016 10:01:15 +0000
Subject: Re: [PATCH v7 0/3] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20161129100115.GA20034@stationary.pb.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161123173340.GA24872@angband.pl>
 <1480265509-20922-1-git-send-email-manuel.schoelling@gmx.de>
 <20161127213730.GO11418@dell-m4800.home>
 <1480368499.29156.12.camel@gmx.de>
In-Reply-To: <1480368499.29156.12.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jslaby@suse.cz, gregkh@linuxfoundation.org, kilobyte@angband.pl, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Nov 28, 2016 at 10:28:19PM +0100, Manuel Sch=F6lling wrote:
> Hi Andrey,
>=20
> Adam already discussed some of your notes, but I want to catch up one
> this one:
>=20
> On So, 2016-11-27 at 21:37 +0000, Andrey Utkin wrote:
> > I see the user experience is subpar to what I'm accustomed to (I use
> > Konsole and "Clear Scrollback and Reset" action, default shortcut is
> > Ctrl+Shift+K). The strange behaviour moments have nothing to do with
> > current patchset but are properties of vgacon, though. (I compared it
> > with another PC which runs without this patchset, and it looks like it
> > runs vgacon, too, however, I'm not sure how to ensure this at runtime.)
> I'm not sure what you mean with 'subpar'. Ctrl+Shift+K would probably be
> nice - but it might interfere with some shortcuts of programs.
> Are you missing any other features?
> (I am working on persistent scrollback for framebuffer consoles in the
> mean time...)

I meant that in my terminal of choice, I have single action which does
both of these things at same time:
 - scrollback cleaning (also not leaving screen worth of emptiness in
   scrollback)
 - prompt positioning to top line

That's all. I don't appeal to bring Ctrl+Shift+K hotkey or whatever
else.

Since these cosmetic matters are inherent to vgacon I'm fine with it.

Regarding logout scrollback clearing not working for me. ncurses-6.0-rc1
which I tested it with is the latest available in Gentoo portage, please
confirm whether I need any newer version, or should I tune something
else. I'd appreciate if you also tested your patch with gentoo setup.
