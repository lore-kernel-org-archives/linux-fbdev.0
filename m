From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH 03/05] video: deferred io with physically contiguous memory
Date: Fri, 26 Dec 2008 03:04:48 +0800
Message-ID: <45a44e480812251104w4154080aj2970286e85f35443@mail.gmail.com>
References: <20081219063359.2703.85817.sendpatchset@rx1.opensource.se>
	 <20081219063432.2703.91443.sendpatchset@rx1.opensource.se>
	 <45a44e480812232113g4a0fa80euda568035a3202aee@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <45a44e480812232113g4a0fa80euda568035a3202aee@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, lethal@linux-sh.org, adaplas@gmail.com, linux-sh@vger.kernel.org

On Wed, Dec 24, 2008 at 12:13 AM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> On Fri, Dec 19, 2008 at 1:34 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> From: Magnus Damm <damm@igel.co.jp>
>>
>> Extend the deferred io code from only supporting vmalloc()ed frame
>> buffer memory to support both vmalloc()ed and physically contiguous
>> frame buffer memory.
>>
>> The sh_mobile_lcdcfb hardware does not support scatter gather so
>> we need physically contiguous memory to back our frame buffer.
>>
>> Signed-off-by: Magnus Damm <damm@igel.co.jp>
>> ---
>>
>>  drivers/video/fb_defio.c |   20 +++++++++++++++-----
>>  1 file changed, 15 insertions(+), 5 deletions(-)
>>
>> --- 0003/drivers/video/fb_defio.c
>> +++ work/drivers/video/fb_defio.c       2008-12-19 14:29:45.000000000 +0900
>> @@ -24,6 +24,19 @@
>>  #include <linux/rmap.h>
>>  #include <linux/pagemap.h>
>>
>> +struct page *fb_deferred_io_page(struct fb_info *info, unsigned long offs)

I think this should be a static function.
