From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 11 Nov 2014 16:15:30 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20141111161530.3FBF8C416AF@trevor.secretlab.ca>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140929101805.GB26008@ulmo> <20141001124800.GA21733@ulmo>
 <20141001170517.GF4273@sirena.org.uk> <542C3934.3040409@redhat.com>
 <CAKON4OxzerMyuza-GSfmYiLMqA=Y3HOXko7a8rOcP_8PkHVF3w@mail.gmail.com>
 <542C4404.8040501@wwwdotorg.org> <542CF3C3.2050708@redhat.com>
 <CAKON4Oy8sZ-d6JzWLi7pUeNFE5ge0fr5Tgoc_PSpKcOoiN-0yQ@mail.gmail.com>
 <542D476D.50004@redhat.com>
 <CAKON4OwOFVFZjxN-SJpDJLcyCpNOT4_mjjr9OpgGXmTYvZwT+A@mail.gmail.com>
 <542D4FB9.6090805@redhat.com>
 <CAKON4Oyb3KBWhGgKfwNop7+cwR=p=ZpVs-jfH0iQwm5scfOJ-A@mail.gmail.com>
 <542D5444.8090903@redhat.com>
 <CAKON4OxTmNRxSJum17RZGLLku5dAFPauzqyP0BOF-VC=bD=Hng@mail.gmail.com>
 <542D5C74.4050602@redhat.com>
 <CAKON4OxHeHszmcbMw_LRJbcaFW5JP7Atsa4RMRwWfqMrCueAnQ@mail.gmail.com>
 <542D5F62.60907@redhat.com>
 <CAKON4Oz8mL5jGzBHZeznd5NbPqq93q7PpTDqHHcV_HYSfqBVHA@mail.gmail.com>
 <542D6633.20907@redhat.com>
 <CAKON4OwMf-zXC_B=VqdVNrD_ExC3zGiGUm4j5KKgS-U4cPB2zg@mail.gmail.com>
 <CAGRGNgUUG6TOzC5YJgqqKfCM_iK9KcDXW9DPEr1P5OoO1qwd8w@mail.gm!>
In-Reply-To: <542E56AB.40208@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, 03 Oct 2014 09:56:27 +0200
, Hans de Goede <hdegoede@redhat.com>
 wrote:
> On 10/03/2014 01:31 AM, Julian Calaby wrote:
> > On Fri, Oct 3, 2014 at 1:14 AM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> >> Because you are creating two different device tree nodes describing a
> >> single piece of hardware and that's not suppose to happen in a device
> >> tree.  The accurate description of the hardware is being perverted to
> >> solve a software problem.
> >>
> >> One node describes the hardware in a format to make simplefb happy.
> >> Another node describes the same hardware in a format to make the
> >> device specific driver happy.
> > 
> > Stupid question: What about mangling an existing device node to be
> > simplefb compatible, and writing simplefb to be binding agnostic?
> 
> That will not work, with simplefb a single node represents the currently
> active video output. While in real hardware that may involve multiple
> blocks, e.g on sunxi for hdmi out this involves the compositor (which
> generates video data from 1 or more layers) which feeds into the
> lcd-controller (which in this case is only used to generate hsync + vsync)
> signals really, which feeds into the hdmi encoder, all 3 of which are
> separate hardware blocks with their own clocks, etc.

The answer here should be, 'whoever does the DMA'.

Julian's suggestion is actually the sanest approach, and there is
precedence for doing exactly that in DT, both for serial devices
(of_serial.c) and framebuffers (offb.c).

g.
