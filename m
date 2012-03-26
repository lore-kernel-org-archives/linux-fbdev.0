From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 26 Mar 2012 08:15:17 +0000
Subject: RE: usage of height and width in fb_var_screeninfo
Message-Id: <000b01cd0b28$9471b650$bd5522f0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAGA24ML642uOP1tEp+VOTe0OZQ9S3HnP8Zi+N1n8X-QsjP9P2w@mail.gmail.com>
In-Reply-To: <CAGA24ML642uOP1tEp+VOTe0OZQ9S3HnP8Zi+N1n8X-QsjP9P2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Mar 22, 2012 at 8:53, Jun Nie <niej0001@gmail.com> wrote:
> Does anyone happen to know the usage of below member in
> fb_var_screeninfo? I do not know whether mm stand for geometry size or
> memory, can not find its usage in any driver neither. We considering
> to use it as zoomed size.
> 
> struct fb_var_screeninfo {
>         __u32 height;                   /* height of picture in mm    */
>         __u32 width;                    /* width of picture in mm     */
> 

Yes, right. Both thins are geometry sizes of LCD panel in millimeters.
Some OS platform needs these parameters.
Good luck.

Best regards,
Jingoo Han


