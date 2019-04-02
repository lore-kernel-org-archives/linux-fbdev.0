From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 02 Apr 2019 11:03:45 +0000
Subject: Re: [PATCH] video: fbdev: sis: fix a missing-check bug
Message-Id: <08701e39-95a6-bb8e-9371-222ada5f85b2@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1539981557-13590-1-git-send-email-wang6495@umn.edu>
        <CGME20181029190936epcas4p1b20ed796247238cfed3264b601807ba3@epcas4p1.samsung.com>
        <CAAa=b7ffkENv=OYDToZgr9fK5qnKs8orMXioQ8ABkFHJ+qTpsA@mail.gmail.com>
In-Reply-To: <CAAa=b7ffkENv=OYDToZgr9fK5qnKs8orMXioQ8ABkFHJ+qTpsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, thomas@winischhofer.net, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>


Hi,

Sorry for the late reply.

On 10/29/2018 08:08 PM, Wenwen Wang wrote:
> Hello,
> 
> Can anyone please confirm this bug? Thanks!
> 
> Wenwen
> 
> On Fri, Oct 19, 2018 at 3:39 PM Wenwen Wang <wang6495@umn.edu> wrote:
>>
>> In sisfb_find_rom(), the official pci ROM is checked to see whether it
>> contains the expected value at specific locations. This is done by firstly
>> mapping the rom into the IO memory region 'rom_base' and then invoking
>> sisfb_check_rom() to perform the checks. If the checks succeed, i.e.,
>> sisfb_check_rom() returns 1, the whole content of the rom is then copied to
>> 'myrombase' through memcpy_fromio(). The problem here is that the checks
>> are conducted on the IO region 'rom_base' directly. Given that the device
>> also has the permission to access the IO region, it is possible that a
>> malicious device controlled by an attacker can race to modify the values in
>> the region after the checks but before memcpy_fromio(). By doing so, the
>> attacker can supply unexpected roms, which can cause undefined behavior of
>> the kernel and introduce potential security risk. The following for loop
>> also has a similar issue.

The checks in sisfb_check_rom() seem to verify only that the ROM
content is valid (= it seems to be a valid code not some random
data) by checking few "magic" numbers. There is no checking for
the ROM content being safe from security POV of any kind so I fail
to see how this patch would help against the malicious device
providing insecure ROM content (as it can pass sisfb_check_rom()
checks without a problem)..

>> To avoid the above issue, this patch firstly copies the content of the rom
>> and then performs the checks on the copied version. If all the checks are
>> satisfied, the copied version will then be returned.
>>
>> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
>> ---
>>  drivers/video/fbdev/sis/sis_main.c | 52 ++++++++++++++++----------------------
>>  1 file changed, 22 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
>> index 20aff90..a2d8051 100644
>> --- a/drivers/video/fbdev/sis/sis_main.c
>> +++ b/drivers/video/fbdev/sis/sis_main.c
>> @@ -4089,29 +4089,29 @@ static int __init sisfb_setup(char *options)
>>  }
>>  #endif
>>
>> -static int sisfb_check_rom(void __iomem *rom_base,
>> +static int sisfb_check_rom(unsigned char *rom_base,
>>                            struct sis_video_info *ivideo)
>>  {
>> -       void __iomem *rom;
>> +       unsigned char *rom;
>>         int romptr;
>>
>> -       if((readb(rom_base) != 0x55) || (readb(rom_base + 1) != 0xaa))
>> +       if ((*rom_base != 0x55) || (*(rom_base + 1) != 0xaa))
>>                 return 0;
>>
>> -       romptr = (readb(rom_base + 0x18) | (readb(rom_base + 0x19) << 8));
>> +       romptr = (*(rom_base + 0x18) | (*(rom_base + 0x19) << 8));
>>         if(romptr > (0x10000 - 8))
>>                 return 0;
>>
>>         rom = rom_base + romptr;
>>
>> -       if((readb(rom)     != 'P') || (readb(rom + 1) != 'C') ||
>> -          (readb(rom + 2) != 'I') || (readb(rom + 3) != 'R'))
>> +       if ((*(rom)     != 'P') || (*(rom + 1) != 'C') ||
>> +          (*(rom + 2) != 'I') || (*(rom + 3) != 'R'))
>>                 return 0;
>>
>> -       if((readb(rom + 4) | (readb(rom + 5) << 8)) != ivideo->chip_vendor)
>> +       if ((*(rom + 4) | (*(rom + 5) << 8)) != ivideo->chip_vendor)
>>                 return 0;
>>
>> -       if((readb(rom + 6) | (readb(rom + 7) << 8)) != ivideo->chip_id)
>> +       if ((*(rom + 6) | (*(rom + 7) << 8)) != ivideo->chip_id)
>>                 return 0;
>>
>>         return 1;
>> @@ -4124,6 +4124,10 @@ static unsigned char *sisfb_find_rom(struct pci_dev *pdev)
>>         unsigned char *myrombase = NULL;
>>         size_t romsize;
>>
>> +       myrombase = vmalloc(65536);
>> +       if (!myrombase)
>> +               return NULL;
>> +
>>         /* First, try the official pci ROM functions (except
>>          * on integrated chipsets which have no ROM).
>>          */
>> @@ -4131,20 +4135,15 @@ static unsigned char *sisfb_find_rom(struct pci_dev *pdev)
>>         if(!ivideo->nbridge) {
>>
>>                 if((rom_base = pci_map_rom(pdev, &romsize))) {
>> -
>> -                       if(sisfb_check_rom(rom_base, ivideo)) {
>> -
>> -                               if((myrombase = vmalloc(65536))) {
>> -                                       memcpy_fromio(myrombase, rom_base,
>> -                                                       (romsize > 65536) ? 65536 : romsize);
>> -                               }
>> -                       }
>> +                       memcpy_fromio(myrombase, rom_base,
>> +                                       (romsize > 65536) ? 65536 : romsize);
>>                         pci_unmap_rom(pdev, rom_base);
>> +
>> +                       if (sisfb_check_rom(myrombase, ivideo))
>> +                               return myrombase;
>>                 }
>>         }
>>
>> -       if(myrombase) return myrombase;
>> -
>>         /* Otherwise do it the conventional way. */
>>
>>  #if defined(__i386__) || defined(__x86_64__)
>> @@ -4156,24 +4155,17 @@ static unsigned char *sisfb_find_rom(struct pci_dev *pdev)
>>                         rom_base = ioremap(temp, 65536);
>>                         if (!rom_base)
>>                                 continue;
>> -
>> -                       if (!sisfb_check_rom(rom_base, ivideo)) {
>> -                               iounmap(rom_base);
>> -                               continue;
>> -                       }
>> -
>> -                       if ((myrombase = vmalloc(65536)))
>> -                               memcpy_fromio(myrombase, rom_base, 65536);
>> -
>> +                       memcpy_fromio(myrombase, rom_base, 65536);
>>                         iounmap(rom_base);
>> -                       break;
>>
>> +                       if (sisfb_check_rom(myrombase, ivideo))
>> +                               return myrombase;
>>                 }
>>
>>         }
>>  #endif
>> -
>> -       return myrombase;
>> +       vfree(myrombase);
>> +       return NULL;
>>  }
>>
>>  static void sisfb_post_map_vram(struct sis_video_info *ivideo,
>> --
>> 2.7.4

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
