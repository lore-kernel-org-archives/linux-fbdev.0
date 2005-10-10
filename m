From: Egbert Eich <eich@suse.de>
Subject: Re: VESA, EDID & flat panels
Date: Mon, 10 Oct 2005 10:43:06 +0200
Message-ID: <17226.10650.863824.745616@f33.suse.de>
References: <1128380013.8267.125.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOtFf-0003qu-Bd
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 Oct 2005 01:43:19 -0700
Received: from mx2.suse.de ([195.135.220.15])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EOtFm-0004cf-Gy
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 Oct 2005 01:43:27 -0700
In-Reply-To: benh@kernel.crashing.org wrote on Tuesday, 4 October 2005 at 08:53:33 +1000 
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
To: Discuss issues related to the xorg tree <xorg@lists.freedesktop.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt writes:
 > Hi !
 > 
 > Somebody around here has access to the VESA specs ? I'm trying to figure
 > out if the EDID block, at least on recent flat panels, tells us wether
 > the panel digital input is 6:6:6 or 8:8:8 ... If it's 6:6:6, we should
 > enable dithering in drivers like radeon and "nv", while if 8:8:8, we
 > should not. If not enabling it on a 6 bits panel, we end up with crappy
 > looking gradients, if enabling it on a 8 bits panel, we basically end up
 > sending a 6 bits signal to a 8 bits panel, thus reducing the quality.
 > 

This information is encoded in EDID Version 2 (not to be confused with
the revisions of version 1).
Currently we have no code in X to read out this information. 

Cheers,
	Egbert.




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
