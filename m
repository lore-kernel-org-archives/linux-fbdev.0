From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] Fix maxine compilation error
Date: Wed, 24 May 2006 08:20:08 +0800
Message-ID: <4473A6B8.2040709@gmail.com>
References: <20060509210114.GA13897@deprecation.cyrius.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fih71-0006Gc-2p
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 May 2006 17:20:31 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fih70-0000D8-QH
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 May 2006 17:20:31 -0700
Received: by py-out-1112.google.com with SMTP id z59so2028581pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 May 2006 17:20:26 -0700 (PDT)
In-Reply-To: <20060509210114.GA13897@deprecation.cyrius.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: tbm@cyrius.com

Martin Michlmayr wrote:
> I have no idea if the patch below is correct.

It's correct.

> Are fb_get_fix/fb_get_var
> still needed?

With 2.6, not anymore.

>  Is there any information about converting fb drivers to
> the 2.6 api?

None in terms of conversion.  But skeletonfb.c in the video
directory might help.

Tony


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
