From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] s3c2410fb - initialise device_driver
 .owner
Date: Mon, 10 Oct 2005 16:23:49 +0800
Message-ID: <434A2515.3030708@gmail.com>
References: <20051010010522.GA28414@home.fluff.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOsxF-0002lX-Es
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 Oct 2005 01:24:17 -0700
Received: from zproxy.gmail.com ([64.233.162.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EOsxM-0007BG-LA
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 10 Oct 2005 01:24:25 -0700
Received: by zproxy.gmail.com with SMTP id i11so645911nzh
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 10 Oct 2005 01:24:00 -0700 (PDT)
In-Reply-To: <20051010010522.GA28414@home.fluff.org>
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
Cc: Ben Dooks <ben-linux@fluff.org>

Ben Dooks wrote:
> Initialise the .owner field, so that if the
> driver is built as a module, the system has
> a link to the owner

Do you want this in 2.6.14? I'm not pushing patches right
now unless they're critical.

Tony


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
