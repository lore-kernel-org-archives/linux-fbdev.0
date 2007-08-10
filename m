From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Section mismatch warnings ( Re:
	2.6.23-rc2-mm2 )
Date: Fri, 10 Aug 2007 12:32:15 -0700
Message-ID: <20070810123215.904369e8.akpm@linux-foundation.org>
References: <20070809224254.11f42716.akpm@linux-foundation.org>
	<46BC3CB1.2090503@googlemail.com> <46BC5C1D.50205@googlemail.com>
	<46BCB6D5.1070506@googlemail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IJaDo-0006u5-Rt for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Aug 2007 12:32:32 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IJaDn-0005gH-JR
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Aug 2007 12:32:32 -0700
In-Reply-To: <46BCB6D5.1070506@googlemail.com>
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
To: Gabriel C <nix.or.die@googlemail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Wim Van Sebroeck <wim@iguana.be>, "shannon.nelson@intel.com" <shannon.nelson@intel.com>, Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org

On Fri, 10 Aug 2007 21:04:53 +0200
Gabriel C <nix.or.die@googlemail.com> wrote:

> Some more
> 
> ...
> 
> WARNING: vmlinux.o(.text+0xce2ce): Section mismatch: reference to .init.data:lowhsync (between 'pm2fb_set_par' and 'pm2fb_pan_display')
> WARNING: vmlinux.o(.text+0xce2e8): Section mismatch: reference to .init.data:lowvsync (between 'pm2fb_set_par' and 'pm2fb_pan_display')
> WARNING: vmlinux.o(.text+0x180d3b): Section mismatch: reference to .init.data: (between 'iTCO_wdt_probe' and 'supermicro_new_unlock_watchdog')
> WARNING: vmlinux.o(.text+0x180e1d): Section mismatch: reference to .init.data: (between 'iTCO_wdt_probe' and 'supermicro_new_unlock_watchdog')
> WARNING: vmlinux.o(.text+0x180e25): Section mismatch: reference to .init.data:iTCO_chipset_info (between 'iTCO_wdt_probe' and 'supermicro_new_unlock_watchdog')
> WARNING: vmlinux.o(.data+0xa74f0): Section mismatch: reference to .init.text:ioat_probe (between 'ioat_pci_drv' and 'ioat_pci_tbl')
> 
> ...
> 
> http://194.231.229.228/kernel/mm/2.6.23-rc2-mm2/randconfig-auto-28

(suitable cc's added)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
