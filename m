From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Telling libSDL that my fbdev can do acclerated fills
Date: Wed, 30 Jun 2004 12:38:06 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406301238.06406.adaplas@hotpop.com>
References: <200406301047.57423.adaplas@hotpop.com> <1088564019.1922.12.camel@gaston> <40E239F8.7070909@bitworks.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BfWrN-0008P1-OG
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Jun 2004 21:38:13 -0700
Received: from twix.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BfWrN-0000Py-DQ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Jun 2004 21:38:13 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by twix.hotpop.com (Postfix) with SMTP id BAB92FCA958
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 30 Jun 2004 04:20:19 +0000 (UTC)
In-Reply-To: <40E239F8.7070909@bitworks.com>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Richard Smith <rsmith@bitworks.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wednesday 30 June 2004 11:56, Richard Smith wrote:
> I'm working on a app that runs on the STPC Atlas and uses libSDL with
> the stpcfb from STPC.  Kernel 2.4.x. I'm currently using 2.4.23 but any
> of later kernels will work.
>
> The Atlas video accelerator supports hardware assisted fills.  I've been
> looking over the stpcfb code and some of the other framebuffer drivers
> and its not obvious to me how the fb system exports out what kind of
> graphics hardware assisted abilities it has.  Or even how you would call
> those abilities if you knew they were avaiable.
>
> All I see is stuff for text related console work.
>
> The STPC is a pretty slow device and my app needs all the speed help it
> can get. libSDL is currently doing software fills since it dosen't know
> otherwise.
>
> I see in the libSDL source code that the FillHWRect funciton pointer for
> the fb driver is set to NULL as if its not possible to realize hardware
> assisted graphics functions via fbdev.
>
> Is this the case or what am I missing?
>

All hardware-assisted drawing functions in fbdev are for use by the console
only.  You might want to try DirectFB (www.directfb.org), I believe they have
ported a lot of libs, including SDL.  However, I doubt they have a gfxdriver for
your hardware though.

Tony




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
