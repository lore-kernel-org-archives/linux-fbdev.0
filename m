From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/6] fbcon: Save blank state last
Date: Tue, 18 Jan 2005 15:07:16 -0800
Message-ID: <20050118150716.04b87537.akpm@osdl.org>
References: <200501180541.17021.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cr2My-0001N5-ID
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Jan 2005 15:02:40 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cr2My-0008DB-3r
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Jan 2005 15:02:40 -0800
In-Reply-To: <200501180541.17021.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: adaplas@hotpop.com, linux-fbdev-devel@lists.sourceforge.net

"Antonino A. Daplas" <adaplas@hotpop.com> wrote:
>
> Save blank state after do_blank|unblank_screen() since this flag is checked
> in fbcon_blank().

The code in this area has changed a bit in my tree, probably due to Roman's
cleanups.  I ended up with:

static void fbcon_fb_blanked(struct fb_info *info, int blank)
{
	struct fbcon_ops *ops = info->fbcon_par;
	struct vc_data *vc;

	if (!ops || ops->currcon < 0)
		return;
	vc = vc_cons[ops->currcon].d;
	if (vc->vc_mode == KD_TEXT &&
	    registered_fb[con2fb_map[ops->currcon]] == info &&
	    CON_IS_VISIBLE(vc)) {
		if (blank)
			do_blank_screen(0);
		else
			do_unblank_screen(0);
	}
	ops->blank_state = blank;
}

Please double-check next -mm. make sure that it all landed OK, thanks.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
