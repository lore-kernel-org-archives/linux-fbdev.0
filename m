From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [Linux-fbdev-devel] Redesign of kernel graphics interface
Date: Thu, 6 May 2004 14:42:14 -0700 (PDT)
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <20040506214214.95811.qmail@web14928.mail.yahoo.com>
References: <20040506231953.B23760@armor.freesurf.fr>
Mime-Version: 1.0
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <20040506231953.B23760@armor.freesurf.fr>
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Souchu <nsouch@free.fr>
Cc: dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

--- Nicolas Souchu <nsouch@free.fr> wrote:
> > A major topic that I missed in the original list was how to handle BSD. DRM
> > is under the BSD license and FB is GPL. If these two code bases are merged,
> > what are we going to do about BSD? I don't know the appropriate BSD lists 
> > to post this to so please forward as necessary.
> 
> What is exactly your question concerning licenses?

FB is GPL licensed. DRM is BSD licensed. If FB and DRM are merged the end result
will be GPL licensed code because of the way the licenses work. To change that
you would have to get permission from every FB contributor to relicense their
contribution from GPL to BSD. I suspect that it is pratically impossible to
track all of the FB contributors down and what do you do if some won't
cooperate? If the FB/DRM combo is GPL it can't be merged back into the BSD
kernels. What we could do is build a merged driver and continue to have some of
the source files licensed BSD and some GPL.

The big reason for merging is memory management. If FB supports multiple heads
it is forced into doing memory management. DRI has memory management needs that
go far beyond what FB needs so a merged system has to use DRM memory management.
Ian has made proposals on how to do this and he is working on improving them. 

BenH and others have made proposals for pushing the mode setting code into a
user space library in order to reduce kernel footprint and ease debugging. Most
of the code needed for this library already exists in the current Linux FB
drivers. I'm not sure if this could be relicensed BSD when it is moved to user
space.


=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
