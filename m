From: Kirti Wankhede <kwankhede@nvidia.com>
Date: Mon, 09 Dec 2019 18:55:39 +0000
Subject: Re: [PATCH v3 11/12] samples: vfio-mdev: constify fb ops
Message-Id: <0d5434e0-3d86-bbb8-6377-94e00b4f0d78@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575390740.git.jani.nikula@intel.com>
 <ddb10df1316ef585930cda7718643a580f4fe37b.1575390741.git.jani.nikula@intel.com>
 <87tv694myu.fsf@intel.com>
In-Reply-To: <87tv694myu.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, kvm@vger.kernel.org



On 12/9/2019 7:31 PM, Jani Nikula wrote:
> On Tue, 03 Dec 2019, Jani Nikula <jani.nikula@intel.com> wrote:
>> Now that the fbops member of struct fb_info is const, we can start
>> making the ops const as well.
>>
>> v2: fix	typo (Christophe de Dinechin)
>>
>> Cc: Kirti Wankhede <kwankhede@nvidia.com>
>> Cc: kvm@vger.kernel.org
>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> 
> Kirti, may I have your ack to merge this through drm-misc please?
> 
> BR,
> Jani.
> 
>> ---
>>   samples/vfio-mdev/mdpy-fb.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/samples/vfio-mdev/mdpy-fb.c b/samples/vfio-mdev/mdpy-fb.c
>> index 2719bb259653..21dbf63d6e41 100644
>> --- a/samples/vfio-mdev/mdpy-fb.c
>> +++ b/samples/vfio-mdev/mdpy-fb.c
>> @@ -86,7 +86,7 @@ static void mdpy_fb_destroy(struct fb_info *info)
>>   		iounmap(info->screen_base);
>>   }
>>   
>> -static struct fb_ops mdpy_fb_ops = {
>> +static const struct fb_ops mdpy_fb_ops = {
>>   	.owner		= THIS_MODULE,
>>   	.fb_destroy	= mdpy_fb_destroy,
>>   	.fb_setcolreg	= mdpy_fb_setcolreg,
> 

Acked-by : Kirti Wankhede <kwankhede@nvidia.com>
