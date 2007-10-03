From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 0/6] Patch series to add	of_platform
	binding to xilinxfb
Date: Wed, 03 Oct 2007 08:15:02 +0800
Message-ID: <1191370502.5238.1.camel@daplas>
References: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IcrtQ-0001uG-NP for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Oct 2007 17:15:14 -0700
Received: from el-out-1112.google.com ([209.85.162.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IcrtN-0003gR-LT
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Oct 2007 17:15:12 -0700
Received: by el-out-1112.google.com with SMTP id y26so2901546ele
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 02 Oct 2007 17:15:08 -0700 (PDT)
In-Reply-To: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Grant Likely <grant.likely@secretlab.ca>, akonovalov@ru.mvista.com, linuxppc <linuxppc@ozlabs.org>, linux-kernel@vger.kernel.org

On Mon, 2007-10-01 at 09:57 -0600, Grant Likely wrote:
> (resend due to mailer issues.  Apologies to anyone receiving this twice)
> 
> This patch series reworks the Xilinx framebuffer driver and then adds
> an of_platform bus binding.  The of_platform bus binding is needed to use
> the driver in arch/powerpc platforms.
> 
> Antonino,
> 
> Assuming there are no major issues, I'd like to get this patch series
> queued up for inclusion in 2.6.24.

Okay.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
