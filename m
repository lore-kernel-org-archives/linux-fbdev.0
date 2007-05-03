From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] pm2fb: removal of pm2fb_par fields
Date: Thu, 03 May 2007 16:17:05 +0800
Message-ID: <1178180225.4606.56.camel@daplas>
References: <4638e8e5cd83c@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjWUy-0003dP-4t for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 May 2007 01:17:12 -0700
Received: from py-out-1112.google.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HjWUw-0000N0-Mn
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 May 2007 01:17:12 -0700
Received: by py-out-1112.google.com with SMTP id a29so340922pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 03 May 2007 01:17:10 -0700 (PDT)
In-Reply-To: <4638e8e5cd83c@wp.pl>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Wed, 2007-05-02 at 21:39 +0200, Krzysztof Helt wrote:

>  	pm2fb_fix.smem_start = pci_resource_start(pdev, 1);
> -	pm2fb_fix.smem_len = default_par->fb_size;
> +	pm2fb_fix.smem_len = pm2fb_fix.smem_len;

We don't need this assignment, correct?

No need to resend, I'll just remove that line.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
