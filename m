From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 30 Apr 2011 17:31:55 +0000
Subject: Re: fbdev test application
Message-Id: <201104301931.55763.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201104301643.23482.laurent.pinchart@ideasonboard.com>
In-Reply-To: <201104301643.23482.laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Geert,

On Saturday 30 April 2011 19:13:47 Geert Uytterhoeven wrote:
> On Sat, Apr 30, 2011 at 16:43, Laurent Pinchart
> 
> <laurent.pinchart@ideasonboard.com> wrote:
> > Hi everybody,
> > 
> > I've developed a small fbdev application for internal test purpose that
> > might be useful to other developers, so I'm releasing it under the GPL.
> 
> Have you ever looked at
> http://git.kernel.org/?p=linux/kernel/git/geert/fbtest.git,
> which is a git clone of CVS module FBdev/utlilities/fbtest of project
> linux-fbdev on sf.net?

I've seen the project, but my fbdev test application serves slightly different 
purposes, as I wanted to control FB devices from the command line, not run a 
test suite. It was also a way for me to learn the FB API, no existing 
application could have properly helped me there :-)

I see that fbtest.git hasn't been updated for quite some time. Do you think we 
should try to merge the projects ?

-- 
Regards,

Laurent Pinchart
