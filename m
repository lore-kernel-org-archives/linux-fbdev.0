From: Simon Vincent <simon.vincent@xsilon.com>
Date: Wed, 20 May 2015 16:03:00 +0000
Subject: Re: distorted text
Message-Id: <555CB034.1030807@xsilon.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <555C660B.2080808@xsilon.com>
In-Reply-To: <555C660B.2080808@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Sorry slightly incorrect I upgraded to linux v4.1-rc4.

I have done some testing and the display works correctly with clear text 
on Linux v4.0 but is distorted/corrupted on v4.1-rc1. (These are tagged 
releases from https://github.com/torvalds/linux).

I have had a look at the changes but I can't find anything that might 
cause the problem although I don't know much about this part of Linux.
Any ideas?

Simon

On 20/05/15 11:46, Simon Vincent wrote:
> Hi,
>
> I have previously been using Linux 3.16 with a OLED 128x32 display 
> setup as a fbconsole. This was working well until I upgraded to linux 
> 4.0. Now the console text is displayed on the OLED but the text is no 
> longer clear, it looks distorted.
> I have uploaded a photo of the problem here. 
> http://s3.postimg.org/66a7lrp2b/IMG_20150520_114135_2.jpg
>
> Is this a known bug?
>
> Simon
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

