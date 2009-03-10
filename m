From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] video: deferred io cleanup fix for
	sh_mobile_lcdcfb
Date: Tue, 10 Mar 2009 15:19:35 +0900
Message-ID: <20090310061935.GD10393@linux-sh.org>
References: <20090310060849.22278.94445.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lethal@linux-sh.org>) id 1LgvhJ-00014b-I5
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Mar 2009 06:44:17 +0000
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]
	helo=master.linux-sh.org)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LgvhG-0003Du-P4
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Mar 2009 06:44:17 +0000
Content-Disposition: inline
In-Reply-To: <20090310060849.22278.94445.sendpatchset@rx1.opensource.se>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-sh@vger.kernel.org

On Tue, Mar 10, 2009 at 03:08:49PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Fix deferred io cleanup patch in the sh_mobile_lcdcfb driver.
> 
> If probe() fails early the sh_mobile_lcdc_stop() function will
> be called to clean up deferred io. This patch modifies the
> code to only call fb_deferred_io_cleanup() after deferred io
> has been initialized. 
> 
> With this patch applied we no longer hit BUG_ON() inside
> fb_deferred_io_cleanup(). Triggers on a Migo-R with the
> SYS QVGA panel board unmounted.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Rolled in to the for-2.6.29 queue, thanks.

------------------------------------------------------------------------------
