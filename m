From: Jun Nie <niej0001@gmail.com>
Date: Thu, 22 Mar 2012 11:52:59 +0000
Subject: usage of height and width in fb_var_screeninfo
Message-Id: <CAGA24ML642uOP1tEp+VOTe0OZQ9S3HnP8Zi+N1n8X-QsjP9P2w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Does anyone happen to know the usage of below member in
fb_var_screeninfo? I do not know whether mm stand for geometry size or
memory, can not find its usage in any driver neither. We considering
to use it as zoomed size.

struct fb_var_screeninfo {
        __u32 height;                   /* height of picture in mm    */
        __u32 width;                    /* width of picture in mm     */

Jun
