From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 10 Jul 2020 14:23:42 +0000
Subject: Re: [PATCH][next] fbdev/fb.h: Use struct_size() helper in kzalloc()
Message-Id: <034da22f-cb7e-3af6-eb35-49a4fba82433@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200617175647.GA26370@embeddedor>
 <CGME20200620112727eucas1p12a623b3bba4c55cad9115287d57b55a6@eucas1p1.samsung.com>
 <20200620112719.GC16901@ravnborg.org>
In-Reply-To: <20200620112719.GC16901@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-fbdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org


On 6/20/20 1:27 PM, Sam Ravnborg wrote:
> Hi Gustavo.
> 
> On Wed, Jun 17, 2020 at 12:56:47PM -0500, Gustavo A. R. Silva wrote:
>> Make use of the struct_size() helper instead of an open-coded version
>> in order to avoid any potential type mistakes.
>>
>> This code was detected with the help of Coccinelle and, audited and
>> fixed manually.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> struct_size is defined in overflow.h - which is not included by fs.h.
> So we rely on overflow.h being pulled in by some other header - maybe
> slab.h in this case.
> Seems fragile, should this patch add an include of overflow.h?

$ git grep struct_size drivers/|wc -l
697

$ git grep overflow\\.h drivers/|wc -l
8

$ git grep overflow\\.h include/linux/
include/linux/device.h:#include <linux/overflow.h>
include/linux/mm.h:#include <linux/overflow.h>
include/linux/slab.h:#include <linux/overflow.h>
include/linux/vmalloc.h:#include <linux/overflow.h>

so I've applied the patch as it is (hoping that the issue is so
widespread that no-one tries to remove overflow.h from slab.h
without fixing drivers at the same time)..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> 	Sam
> 
>> ---
>>  include/linux/fb.h | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/fb.h b/include/linux/fb.h
>> index 3b4b2f0c6994..2b530e6d86e4 100644
>> --- a/include/linux/fb.h
>> +++ b/include/linux/fb.h
>> @@ -506,8 +506,9 @@ struct fb_info {
>>  };
>>  
>>  static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
>> -	struct apertures_struct *a = kzalloc(sizeof(struct apertures_struct)
>> -			+ max_num * sizeof(struct aperture), GFP_KERNEL);
>> +	struct apertures_struct *a;
>> +
>> +	a = kzalloc(struct_size(a, ranges, max_num), GFP_KERNEL);
>>  	if (!a)
>>  		return NULL;
>>  	a->count = max_num;
>> -- 
>> 2.27.0
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://protect2.fireeye.com/url?k{ae4d09-26604cda-7bafc646-000babff317b-7eab3a2caa4b8b73&q=1&u=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel
