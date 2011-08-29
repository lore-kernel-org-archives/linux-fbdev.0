From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 29 Aug 2011 06:02:38 +0000
Subject: Re: linux-next tree addition request (fbdev)
Message-Id: <20110829060238.GB31809@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4E54FF5E.5050308@gmx.de> <20110825003353.e930fc7a664dd99c953b555c@canb.auug.org.au> <20110829021930.0112cf98fbafd7380e09e164@canb.auug.org.au>
In-Reply-To: <20110829021930.0112cf98fbafd7380e09e164@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-next@vger.kernel.org, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Mon, Aug 29, 2011 at 02:19:30AM +1000, Stephen Rothwell wrote:
> Hi Florian,
> 
> On Thu, 25 Aug 2011 00:33:53 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Wed, 24 Aug 2011 13:40:46 +0000 Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
> > >
> > > can you please add
> > > 
> > >     git://github.com/schandinat/linux-2.6.git fbdev-next
> > > 
> > > to linux-next. It collects patches for the frame buffer subsystem.
> > > Can you please add the linux-fbdev@vger.kernel.org mailing list as additional
> > > contact for warnings/errors/problems?
> > > 
> > > You probably want to drop Paul's fbdev branches as they contain some outdated
> > > patches that will conflict with the newer versions.
> > 
> > OK, Paul is still listed as the frame buffer subsystem maintainer, so I
> > will need an Ack from him.  When I get that, I will replace his tree with
> > yours.  I assume someone will update the MAINTAINERS file.
> > 
> > I also have another tree from Paul (called fbdev-current) that contained
> > fixes for Linus' current release.  I also assume that that tree will be
> > dropped (unless you have a new version of that as well).
> 
> Ping?  Anyone?
> 
As long as Florian is taking care of the backlog of the stuff that is
already sitting in that branch, I have no problems with it being dropped.
I'm not planning on pushing any updates to it anyways.
