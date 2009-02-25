From: "Christian T. Steigies" <cts@debian.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 4/4] cirrusfb: fix error paths in cirrusfb_xxx_register()
Date: Wed, 25 Feb 2009 10:37:30 +0100
Message-ID: <20090225093729.GA18736@chumley.debian.net>
References: <20090224223702.86f7e129.krzysztof.h1@poczta.fm> <10f740e80902250048j31a9a2c5n5c39066ba156c10d@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <10f740e80902250048j31a9a2c5n5c39066ba156c10d@mail.gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, linux-m68k@lists.linux-m68k.org

On Wed, Feb 25, 2009 at 09:48:40AM +0100, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Tue, Feb 24, 2009 at 22:37, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> > It is not an end to cirrusfb patches unfortunately.
> > I have just got a GD5446 (Picasso4) and it locks up
> > my computer when the cirrusfb module is loaded.
> > Time to fix this model as well...
> 
> Cool! Which Amiga model do you have?
> 
> The Picasso4 is also not yet supported in Zorro II mode. There are some docs
> available (it's just about using the right offsets), but as I don't
> have the hardware,
> I never did it myself. Christian Steigies is probably most interested...

Definetely! I have a PIV in my A2000 and would really like to get a decent
resolution out of it. If I ever get it to run again...

Christian
