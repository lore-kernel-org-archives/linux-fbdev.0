From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH 1/2] ARM S3C2410 framebuffer driver
Date: Mon, 05 Sep 2005 08:39:21 +0200
Message-ID: <85ek845886.fsf@Orfeo.duckcorp.org>
References: <8564th6srr.fsf@Orfeo.duckcorp.org> <431B17BD.4090209@gmail.com>
	<85u0h05z68.fsf@Orfeo.duckcorp.org> <431B9E1F.3010607@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ECAde-0000z6-Dx
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Sep 2005 23:39:30 -0700
Received: from orfeo.duckcorp.org
	([62.4.21.229] helo=mx.duckcorp.org ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ECAdd-0002Yk-6m
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Sep 2005 23:39:30 -0700
In-Reply-To: <431B9E1F.3010607@gmail.com> (Antonino A. Daplas's message of
	"Mon, 05 Sep 2005 09:23:43 +0800")
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
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, linux-fbdev-devel@lists.sourceforge.net

"Antonino A. Daplas" <adaplas@gmail.com> writes:

> Arnaud Patard (Rtp) wrote:
>> "Antonino A. Daplas" <adaplas@gmail.com> writes:
>> 
>
> I noticed one more thing:
>
>> +	if (var->bits_per_pixel == 16) {
>> +		var->red.offset		= 11;
>> +		var->green.offset	= 5;
>> +		var->blue.offset	= 0;
>> +		var->red.length		= 5;
>> +		var->green.length	= 6;
>> +		var->blue.length	= 5;
>> +		var->transp.length	= 0;
>> +	} else {
>> +		var->red.length		= 8;
>> +		var->red.offset		= 0;
>> +		var->green.length	= 8;
>> +		var->green.offset	= 0;
>> +		var->blue.length	= 8;
>> +		var->blue.offset	= 0;
>> +		var->transp.length	= 0;
>> +	}
>
> Your driver supports bits_per_pixel of 1, 2, 4 and 8. It will
> be more correct if you do the above like this:
>
> 		var->red.length		= var->bits_per_pixel;
> 		var->red.offset		= 0;
> 		var->green.length	= var->bits_per_pixel;
> 		var->green.offset	= 0;
> 		var->blue.length	= var->bits_per_pixel;
> 		var->blue.offset	= 0;
>
> Otherwise, your driver will get wrong colors at bpp of 1 and 2
> with fbcon.
>
> If you believe the above is correct, I'll do the correction in
> my tree and you need not send a patch.

yeah, it's correct. This has been changed in a patch that adds STN
support to the driver but this patch needs cleaning and tests before
submission.

Regards,
Arnaud



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
