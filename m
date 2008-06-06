From: Helge Deller <deller@gmx.de>
Subject: Re: [RESEND] [PATCH] convert sticore.c to PCI ROM API
Date: Fri, 06 Jun 2008 23:23:10 +0200
Message-ID: <4849AABE.7040805@gmx.de>
References: <20080605231327.af9cc9e6.krzysztof.h1@poczta.fm> <1212704814.4241.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1212704814.4241.37.camel@localhost.localdomain>
Sender: linux-parisc-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, linux-parisc@vger.kernel.org

James Bottomley wrote:
>>  static struct sti_struct * __devinit
>> -sti_try_rom_generic(unsigned long address, unsigned long hpa, struct pci_dev *pd)
>> +sti_try_rom_generic(unsigned long address, unsigned long hpa,
>> +		    struct pci_dev *pd)
>>  {
>> +	char __iomem *rom_base = (char __iomem *) address;
>>  	struct sti_struct *sti;
>>  	int ok;
>> -	u32 sig;
>> +	__le32 sig;
>>  
>>  	if (num_sti_roms >= MAX_STI_ROMS) {
>>  		printk(KERN_WARNING "maximum number of STI ROMS reached !\n");
>> @@ -808,7 +810,7 @@ test_rom:
>>  	sig = gsc_readl(address);
> 
> Since gsc_readl() has (designedly) no endianness type, doesn't this give
> a sparse warning?

No, it doesn't.
But maybe I tested it wrongly?

[hd@p100 linus-linux-2.6]# REAL_CC=hppa-linux-gcc cgcc -Wbitwise 
-Wp,-MD,drivers/video/console/.sticore.o.d  -nostdinc -isystem 
/opt/palinux33/lib/gcc-lib/hppa-linux/3.3.4/include -D__KERNEL__ 
-Iinclude  -include include/linux/autoconf.h -Wall -Wundef 
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common 
-Werror-implicit-function-declaration -Os   -pipe -mno-space-regs 
-mfast-indirect-calls -mdisable-fpregs -ffunction-sections -march=1.1 
-mschedule=7100LC -fomit-frame-pointer       -D"KBUILD_STR(s)=#s" 
-D"KBUILD_BASENAME=KBUILD_STR(sticore)" 
-D"KBUILD_MODNAME=KBUILD_STR(sticore)" -c -o 
drivers/video/console/sticore.o drivers/video/console/sticore.c
drivers/video/console/sticore.c:32:19: warning: symbol 'default_sti' was 
not declared. Should it be static?
drivers/video/console/sticore.c:241:1: warning: symbol 'sti_rom_copy' 
was not declared. Should it be static?
drivers/video/console/sticore.c:481:24: warning: symbol 
'sti_select_fbfont' was not declared. Should it be static?
drivers/video/console/sticore.c:544:24: warning: symbol 
'sti_select_font' was not declared. Should it be static?
drivers/video/console/sticore.c:710:16: warning: symbol 
'sti_get_wmode_rom' was not declared. Should it be static?
drivers/video/console/sticore.c:727:1: warning: symbol 'sti_read_rom' 
was not declared. Should it be static?
drivers/video/console/sticore.c:975:1: warning: symbol 'sti_pci_tbl' was 
not declared. Should it be static?

Helge
