From: Jiri Slaby <jslaby@suse.cz>
Date: Fri, 29 Jul 2016 10:53:44 +0000
Subject: Re: [PATCH 3/3] mdacon: replace MDA_ADDR macro by inline function
Message-Id: <e3dcc9f7-711a-5073-38a1-3cdc5596bfb0@suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160725152440.6734-1-jslaby@suse.cz>
 <20160725152440.6734-3-jslaby@suse.cz>
 <1469462669.1900.181.camel@perches.com>
In-Reply-To: <1469462669.1900.181.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>, tomi.valkeinen@ti.com
Cc: plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org

On 07/25/2016, 06:04 PM, Joe Perches wrote:
> On Mon, 2016-07-25 at 17:24 +0200, Jiri Slaby wrote:
>> MDA_ADDR is one of those macros which could be an inline function. So
>> convert MDA_ADDR to mda_addr.
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> ---
>>  drivers/video/console/mdacon.c | 19 +++++++++++--------
>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
>> index 814606bd26d1..24fe55134eb5 100644
>> --- a/drivers/video/console/mdacon.c
>> +++ b/drivers/video/console/mdacon.c
>> @@ -420,17 +420,20 @@ static void mdacon_invert_region(struct vc_data *c, u16 *p, int count)
>>  	}
>>  }
>>  
>> -#define MDA_ADDR(x, y)  (mda_vram_base + (y)*mda_num_columns + (x))
>> +static inline u16 *mda_addr(unsigned int x, unsigned int y)
> 
> Are you sure about the unsigned?
> All of the changed use are taking int

Yeah, they are really absolute x and y coordinates.

thanks,
-- 
js
suse labs
