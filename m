From: James Simmons <jsimmons@transvirtual.com>
Subject: Framebuffer policy [ was Re: Linux 2.5.19]
Date: Wed, 29 May 2002 22:10:36 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.10.10205292154360.12660-100000@www.transvirtual.com>
References: <20020530003133.H30585@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17DIDA-0004Wl-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 May 2002 22:10:56 -0700
In-Reply-To: <20020530003133.H30585@flint.arm.linux.org.uk>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: Martin Dalecki <dalecki@evision-ventures.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>


> This is about people who think they're god nicking patches from
> the author and maintainer of drivers and bypassing the maintainer
> completely.

Please no fighting. It is clear the problem is the lack of order here.
I understand how Russell feels. Most of the time people send in new fbdev
drivers or good size patches without consulting me or Geert first. I have
to say it has gotten better. So here goes for policy time:

--------------------------------------------------------------------
             Framebuffer driver policy.

1) Basic one or few line fixes for drivers can go straight into the
   kernel. Please don't abuse this.

2) All new drivers must be posted to the fbdev developement list for
   peer review. Me and/or geert have final fword about them going in.
   Please note we do get busy so just harass me about your driver. I
   will not be offended and it pushs me to go do it. I'm the type of
   person if I don't do it right away I will forget.

   linux-fbdev-devel@lists.sourceforge.net

3) Large changes should be posted to both the framebuffer list and the
   kernel mailing list as well to the framebuffer author if they
   are know. Again it is for peer review and wide scale testing. We 
   need to make clear what drivers where effect. And yes if you are the 
   maintainer of a driver you should mail yourself. It makes it easier
   for users to reply to you directly.  

If no one follows these rules then their changes will be ignored. No
exceptions including for myself.

-----------------------------------------------------------------
How does this sound? Again sorry about the confusion.




_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
