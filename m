From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Bug#347186: linux-image-2.6.14-2-alpha-generic: garbled Matrox framebuffer
Date: Wed, 11 Jan 2006 12:48:48 +0100
Message-ID: <20060111114848.GA6453@localhost.localdomain>
References: <20060109090849.GB3481@tennyson.dodds.net> <20060109093517.GA23253@localhost.localdomain> <20060109105146.GE3481@tennyson.dodds.net> <20060111102827.GF7691@nancy> <43C4EAD4.2090704@pol.net>
Reply-To: Sven Luther <sven.luther@wanadoo.fr>,
	347186@bugs.debian.org
Mime-Version: 1.0
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.347186.B347186.113698026919986@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <43C4EAD4.2090704@pol.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@pol.net>
Cc: maximilian attems <maks@sternwelten.at>, Steve Langasek <vorlon@debian.org>, 347186@bugs.debian.org, Sven Luther <sven.luther@wanadoo.fr>, linux-fbdev-devel@lists.sourceforge.net

On Wed, Jan 11, 2006 at 07:24:04PM +0800, Antonino A. Daplas wrote:
> maximilian attems wrote:
> > dear adaplas,
> > 
> > could you please take a look at this matroxfb debian bug report:
> > http://bugs.debian.org/347186
> > 
> > On Mon, 09 Jan 2006, Steve Langasek wrote:
> > 
> > <snipp>
> >>>> Sigh, can't get a break with alpha kernel support around here.  After
> >>>> upgrading to 2.6.14 (from 2.4.27), the Matrox framebuffer no longer works
> >>>> correctly on my alpha with a Matrox Millenium II.  The matroxfb_base module
> >>>> loads without error, but gives me corrupt video output only.
> >>> Try turning off acceleration.
> >> Doesn't make a difference.
> >>
> >> What did make a difference was, after googling, loading fbcon manually
> >> before loading matroxfb_base.  Given that I'm loading matroxfb_base by hand
> >> (/etc/modules), it's not getting loaded via udev or anything like that, it
> >> seems to me that it's my responsibility to load fbcon by hand as well, but
> >> it's still something of an unexpected change from 2.4.
> 
> You can always compile fbcon statically and the fbdev as modules so you get
> the same behavior as 2.4.  (The separation of fbdev from fbcon is advantageous
> in embedded systems where the console is not needed).
> 
> (There's a new document Documentation/fb/fbcon.txt that explains some of the
> changes. It's new in 2.6.15).

Also, note : 

  http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=311815
  [powerpc] screen garbage when using matroxfb acceleration

this is on powerpc64 though, so it may be some 64-bitness issue.

Friendly,

Sven Luther
