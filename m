From: Alan Hourihane <alanh@fairlite.demon.co.uk>
Subject: Re: DRM & MTRR's
Date: Mon, 10 Oct 2005 20:58:27 +0100
Message-ID: <1128974307.9450.66.camel@jetpack.demon.co.uk>
References: <1127475052.9377.18.camel@jetpack.demon.co.uk>
	 <43340C3E.5070005@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-admin@lists.sourceforge.net>
In-Reply-To: <43340C3E.5070005@gmail.com>
Sender: dri-devel-admin@lists.sourceforge.net
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="us-ascii"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: dri-devel@lists.sf.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2005-09-23 at 22:07 +0800, Antonino A. Daplas wrote:
> Alan Hourihane wrote:
> > Has anyone any objections to me removing the MTRR code from the DRM.
> > 
> > It doesn't have the intimate knowledge needed to properly configure
> > MTRR's and fails in many cases.
> > 
> > There are two cases currently, one for the framebuffer and a second for
> > the entire AGP space.
> > 
> > Certainly in Intel hardware this is the same memory space and you always
> > get bogus error messages in your kernel logs as things fail due to lack
> > of boundary checks.
> > 
> > I'm more of the opinion that it should be left up to userspace to
> > configure MTRR's if it indeed wants them and we shouldn't force them
> > within the DRM.
> > 
> > Additionally, the Xserver (for user-space) already sets up the MTRR's,
> > as should Xgl (Xegl) or other user space apps.
> > 
> > What makes the situation a little worse is that vesafb (and other *fb
> > drivers) also setup an mtrr which frequently stops subsequent processes
> > from adding a new one that overlaps an existing write-combining range.
> > But the *fb drivers do provide a nomtrr option in many cases. (But I'd
> > like to remove it from them too :-) or at least default those to off)
> 
> I don't know the repercussions of defaulting to nomtrr. But I would
> surmise that a large percentage of users gives more importance to X/DRI
> performance than console performance (majority of vesafb users still
> use redraw for scrolling where ypan is magnitudes faster, so I'm pretty
> sure defaulting vesafb to nomtrr will not be noticeable to most users,
> they probably go straight to X anyway :-)
> 
> I cannot decide on this alone, so I'm going to CC the fbdev-devel list.
> Perhaps I can submit a patch that defaults all drivers to nomtrr and a
> big warning about mtrr not being set in dmesg. If I don't get any
> backlash for a few patch cycles, I can make this permanent.

Tony,

What was the outcome of this in kernel land ??

Just to give you an idea of why it really causes problems.

If you are using vesafb and it sets up it's own mtrr for usually the
first 4MB of the framebuffer. Now, X will fail to set it's MTRR. And
thus the first 4MB remains write-combined.

Running the isosurf benchmark from Mesa, shows only 300fps. Yet, doing
echo "disable=3" > /proc/mtrr to remove that vesafb mtrr and allows X to
setup the full range results in isosurf jumping to 650fps.

Defaulting vesafb (and the others) to nomtrr which save us this pain.

Alan.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
--
