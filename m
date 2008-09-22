From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev: don't allow to set a video
 mode via vga= if FB doesn't support it
Date: Mon, 22 Sep 2008 13:28:30 -0700
Message-ID: <20080922132830.359bc001.akpm@linux-foundation.org>
References: <20080921210219.GC21215@spock.one.pl>
	<20080922214747.c8bc57eb.krzysztof.h1@poczta.fm>
	<20080922220054.4e74c099@neptune.home>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754061AbYIVU3Y@vger.kernel.org>
In-Reply-To: <20080922220054.4e74c099@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Bruno =?ISO-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: krzysztof.h1@poczta.fm, spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Mon, 22 Sep 2008 22:00:54 +0200
Bruno Pr=E9mont <bonbons@linux-vserver.org> wrote:

> From: Michal Januszewski <spock@gentoo.org>
> > Currently, it is possible to set a VESA graphics mode at boot time
> > via the vga=3D parameter even when no framebuffer driver supporting
> > this is configured.  This could lead to the system booting with a
> > black screen, without a usable console.
> >=20
> This looks pretty much the same as what I requested some time ago:
>=20
> http://bugzilla.kernel.org/show_bug.cgi?id=3D8062
>=20
> Would need to check -mm archives for the actual patch.
>=20
> Don't remember why it did not make it to mainline...

If someone can give me some idea of what that patch looked
like then I can go hunt it down, find out why it didn't make it.
