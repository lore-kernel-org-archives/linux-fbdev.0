From: Joseph Fannin <jfannin@gmail.com>
Subject: Re: intelfb updates
Date: Sun, 2 Jul 2006 20:15:12 -0400
Message-ID: <20060703001512.GA4163@nineveh.rivenstone.net>
References: <21d7e9970605270158l1ee8551cw7cc8910378cc43de@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FxCYQ-0006OO-1S for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 02 Jul 2006 17:44:46 -0700
Received: from nz-out-0102.google.com ([64.233.162.204])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FxCYO-0005DS-Cb
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 02 Jul 2006 17:44:45 -0700
Received: by nz-out-0102.google.com with SMTP id o1so775325nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 02 Jul 2006 17:44:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <21d7e9970605270158l1ee8551cw7cc8910378cc43de@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net, airlied@gmail.com



Dave Airlied wrote:

> I've just pushed my latest intelfb-2.6 tree to kernel.org, it contains
> the patches from Dennis, and a sync of my X.org code.

> Dennis I'd appreciate you testing this on your i945 system to see if
> the PLL register problem is fixed, I'm a bit snowed under and my 945
> isn't connected to anything at the moment.

> I'd like to push this tree to Linus for 2.6.18, I'll go back and test
> it on my i865, i915 and i945 at some point soon.

    After taking the intelfb directory from Linus' tree and plopping
it into 2.6.17, I can report that intelfb works on my i945GM.  This is
on an Apple MacBook, using the Apple BIOS emulation and vga=792 .

    I don't know if this is news -- and I didn't run that kernel very
long -- but it does make a framebuffer console and X continued to
start and appeared to run the way it should.

--
Joseph Fannin
jfannin@gmail.com

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
