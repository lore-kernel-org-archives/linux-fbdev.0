From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9006] New: incorrect
 method to turn off DPLL in intel framebuffer driver
Date: Tue, 11 Sep 2007 00:49:41 -0700
Message-ID: <20070911004941.28b1332f.akpm@linux-foundation.org>
References: <bug-9006-10286@http.bugzilla.kernel.org/>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IV0Vm-0004Hs-Ml for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Sep 2007 00:50:18 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IV0Vm-0007mf-Cc
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Sep 2007 00:50:18 -0700
In-Reply-To: <bug-9006-10286@http.bugzilla.kernel.org/>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@pol.net>
Cc: william.pan@kontron.cn, bugme-daemon@bugzilla.kernel.org

On Tue, 11 Sep 2007 00:40:22 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9006
> 
>            Summary: incorrect method to turn off DPLL in intel framebuffer
>                     driver
>            Product: Platform Specific/Hardware
>            Version: 2.5
>      KernelVersion: 2.6.18.1
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: i386
>         AssignedTo: platform_i386@kernel-bugs.osdl.org
>         ReportedBy: william.pan@kontron.cn
> 
> 
> in file intelfbhw.c, function intelfbhw_program_mode, the steps to 
> turn off DPLL:
>         tmp = INREG(dpll_reg);
>         dpll_reg &= ~DPLL_VCO_ENABLE;
>         OUTREG(dpll_reg, tmp);
> guess it should be:
>         tmp = INREG(dpll_reg);
>         tmp &= ~DPLL_VCO_ENABLE;
>         OUTREG(dpll_reg, tmp);
> am I right?
> 

?

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
