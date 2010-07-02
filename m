From: Pawel Osciak <p.osciak@samsung.com>
Date: Fri, 02 Jul 2010 12:56:06 +0000
Subject: RE: [PATCH v3 01/12] s3c-fb: Fix various null references on
Message-Id: <003c01cb19e5$ef8c5df0$cea519d0$%osciak@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1277712538-23188-1-git-send-email-p.osciak@samsung.com>
	<1277712538-23188-2-git-send-email-p.osciak@samsung.com>
	<4C2DB6A2.2040005@simtec.co.uk>
In-Reply-To: <4C2DB6A2.2040005@simtec.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>Ben Dooks <ben@simtec.co.uk> wrote:
>On 28/06/10 09:08, Pawel Osciak wrote:
>> @@ -819,7 +820,8 @@ static void s3c_fb_release_win(struct s3c_fb *sfb,
>struct s3c_fb_win *win)
>>  {
>>  	if (win->fbinfo) {
>>  		unregister_framebuffer(win->fbinfo);
>> -		fb_dealloc_cmap(&win->fbinfo->cmap);
>> +		if (&win->fbinfo->cmap)
>> +			fb_dealloc_cmap(&win->fbinfo->cmap);
>
>did you really mean &win->fbinfo->cmap? surely that will end up
>always evaluating to true?
>

It should have actually been:

+		if (win->fbinfo->cmap.len)
+			fb_dealloc_cmap(&win->fbinfo->cmap);

Thanks, will post a fix for this patch.


Best regards
--
Pawel Osciak
Linux Platform Group
Samsung Poland R&D Center


