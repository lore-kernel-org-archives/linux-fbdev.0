From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] Fix possible leak in fbcon code. (fwd)
Date: Fri, 3 Sep 2004 04:39:36 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409030439.36380.adaplas@hotpop.com>
References: <Pine.GSO.4.58.0409021144550.5627@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C2yN5-0005eT-S3
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 02 Sep 2004 13:39:51 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C2yN3-0005rh-Sl
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 02 Sep 2004 13:39:51 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id C22697FC305
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  2 Sep 2004 20:39:37 +0000 (UTC)
In-Reply-To: <Pine.GSO.4.58.0409021144550.5627@waterleaf.sonytel.be>
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
To: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dave Jones <davej@redhat.com>

On Thursday 02 September 2004 17:45, Geert Uytterhoeven wrote:
> ---------- Forwarded message ----------
> Date: Wed, 1 Sep 2004 16:51:22 +0100
> From: Dave Jones <davej@redhat.com>
> To: linux-kernel@vger.kernel.org
> Subject: [PATCH] Fix possible leak in fbcon code.
>
> Spotted with the source checker from Coverity.com.

No, I don't think there's a leak in the original code. It always passes
through this part:

	if (save) {
		q = (unsigned short *) (vc->vc_origin +
					vc->vc_size_row *
					rows);
		scr_memcpyw(q, save, logo_lines * new_cols * 2);
		vc->vc_y += logo_lines;
		vc->vc_pos += logo_lines * vc->vc_size_row;
		kfree(save);
	}

Tony




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
