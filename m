From: Andrew Morton <akpm@osdl.org>
Subject: Re: Radeon framebuffer weirdness in -mm2
Date: Thu, 20 Jan 2005 20:07:11 -0800
Message-ID: <20050120200711.4313dbcc.akpm@osdl.org>
References: <20050120232122.GF3867@waste.org>
	<20050120153921.11d7c4fa.akpm@osdl.org>
	<20050120234844.GF12076@waste.org>
	<20050120160123.14f13ca6.akpm@osdl.org>
	<20050121035758.GH12076@waste.org>
	<20050120200530.4d5871f9.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Crq5D-0004Ti-Qb
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Jan 2005 20:07:39 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Crq5C-0003iS-CJ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Jan 2005 20:07:39 -0800
In-Reply-To: <20050120200530.4d5871f9.akpm@osdl.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: mpm@selenic.com, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, benh@kernel.crashing.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Next suspects would be:
> 
>  +cleanup-vc-array-access.patch
>  +remove-console_macrosh.patch
>  +merge-vt_struct-into-vc_data.patch
> 
> 

Make that:

+cleanup-vc-array-access.patch
+remove-console_macrosh.patch
+merge-vt_struct-into-vc_data.patch
+vgacon-fixes-to-help-font-restauration-in-x11.patch

and the fbdev updates, maybe:

+radeonfb-set-accelerator-id.patch
+vesafb-change-return-error-id.patch
+intelfb-workaround-for-830m.patch
+fbcon-save-blank-state-last.patch
+backlight-fix-compile-error-if-config_fb-is-unset.patch
+matroxfb-fb_matrox_g-kconfig-changes.patch




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
