From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 1/2] ARM S3C2410 framebuffer driver
Date: Mon, 05 Sep 2005 09:23:43 +0800
Message-ID: <431B9E1F.3010607@gmail.com>
References: <8564th6srr.fsf@Orfeo.duckcorp.org> <431B17BD.4090209@gmail.com> <85u0h05z68.fsf@Orfeo.duckcorp.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EC5ie-00009h-D3
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Sep 2005 18:24:20 -0700
Received: from zproxy.gmail.com ([64.233.162.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EC5id-0000Rs-5d
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Sep 2005 18:24:20 -0700
Received: by zproxy.gmail.com with SMTP id s18so634773nze
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 04 Sep 2005 18:24:13 -0700 (PDT)
In-Reply-To: <85u0h05z68.fsf@Orfeo.duckcorp.org>
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
To: "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Arnaud Patard (Rtp) wrote:
> "Antonino A. Daplas" <adaplas@gmail.com> writes:
> 

I noticed one more thing:

> +	if (var->bits_per_pixel == 16) {
> +		var->red.offset		= 11;
> +		var->green.offset	= 5;
> +		var->blue.offset	= 0;
> +		var->red.length		= 5;
> +		var->green.length	= 6;
> +		var->blue.length	= 5;
> +		var->transp.length	= 0;
> +	} else {
> +		var->red.length		= 8;
> +		var->red.offset		= 0;
> +		var->green.length	= 8;
> +		var->green.offset	= 0;
> +		var->blue.length	= 8;
> +		var->blue.offset	= 0;
> +		var->transp.length	= 0;
> +	}

Your driver supports bits_per_pixel of 1, 2, 4 and 8. It will
be more correct if you do the above like this:

		var->red.length		= var->bits_per_pixel;
		var->red.offset		= 0;
		var->green.length	= var->bits_per_pixel;
		var->green.offset	= 0;
		var->blue.length	= var->bits_per_pixel;
		var->blue.offset	= 0;

Otherwise, your driver will get wrong colors at bpp of 1 and 2
with fbcon.

If you believe the above is correct, I'll do the correction in
my tree and you need not send a patch.

Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
