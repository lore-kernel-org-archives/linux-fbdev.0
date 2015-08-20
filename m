From: yalin wang <yalin.wang2010@gmail.com>
Date: Thu, 20 Aug 2015 11:30:58 +0000
Subject: Re: [RFC] fbdev/riva:change to use generice function to implement reverse_order()
Message-Id: <867D66CD-9A3B-4536-B537-8C065C85E497@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <C21B8761-0447-45A6-B833-742E3B4C13DE@gmail.com> <55D5B3A9.6040901@ti.com>
In-Reply-To: <55D5B3A9.6040901@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: adaplas@gmail.com, plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>


> On Aug 20, 2015, at 19:02, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> 
> 
> On 10/08/15 13:12, yalin wang wrote:
>> This change to use swab32(bitrev32()) to implement reverse_order()
>> function, have better performance on some platforms.
> 
> Which platforms? Presuming you tested this, roughly how much better
> performance? If you didn't, how do you know it's faster?

i investigate on arm64 platforms:


for (j = dsize; j--;) {
                        tmp = data[k++];
                        tmp = reverse_order(tmp);
                        NVDmaNext(par, tmp);
 bac:   110006a4        add     w4, w21, #0x1
 bb0:   5ac000a3        rbit    w3, w5

        if (dsize) {
                NVDmaStart(info, par, RECT_EXPAND_TWO_COLOR_DATA(0), dsize);

                for (j = dsize; j--;) {
                        tmp = data[k++];
 bb4:   110006d6        add     w22, w22, #0x1
 bb8:   5ac00861        rev     w1, w3
                        tmp = reverse_order(tmp);
                        NVDmaNext(par, tmp);
 bbc:   b9041e64        str     w4, [x19,#1052]
 bc0:   8b3548c2        add     x2, x6, w21, uxtw #2
 bc4:   b9000041        str     w1, [x2]


this is the disassemble code after apply the patch,
only need:
rbit    w3, w5
rev     w1, w3
2 instruction to get the reverse_order() result,
apparently after than the origianl macro code.

> 
>> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
>> ---
>> drivers/video/fbdev/riva/fbdev.c | 19 ++++++-------------
>> 1 file changed, 6 insertions(+), 13 deletions(-)
>> 
>> diff --git a/drivers/video/fbdev/riva/fbdev.c b/drivers/video/fbdev/riva/fbdev.c
>> index f1ad274..4803901 100644
>> --- a/drivers/video/fbdev/riva/fbdev.c
>> +++ b/drivers/video/fbdev/riva/fbdev.c
>> @@ -40,6 +40,7 @@
>> #include <linux/init.h>
>> #include <linux/pci.h>
>> #include <linux/backlight.h>
>> +#include <linux/swab.h>
>> #include <linux/bitrev.h>
>> #ifdef CONFIG_PMAC_BACKLIGHT
>> #include <asm/machdep.h>
>> @@ -84,6 +85,7 @@
>> #define SetBit(n)		(1<<(n))
>> #define Set8Bits(value)		((value)&0xff)
>> 
>> +#define reverse_order(v) swab32(bitrev32(v))
>> /* HW cursor parameters */
>> #define MAX_CURS		32
>> 
>> @@ -451,15 +453,6 @@ static inline unsigned char MISCin(struct riva_par *par)
>> 	return (VGA_RD08(par->riva.PVIO, 0x3cc));
>> }
>> 
>> -static inline void reverse_order(u32 *l)
> 
> I would suggest to do the work in the inline function, instead of a
> macro. And if you keep the function prototype the same, then the changes
> to each reverse_order call site are not needed.
> 

ok, i will change to a inline function. 


