From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 1/1: 2.6.15-rc5-git3] Fixed and updated CyblaFB
Date: Wed, 14 Dec 2005 23:16:23 +0800
Message-ID: <43A03747.9070808@gmail.com>
References: <439EF4CB.8030007@t-online.de> <43A03568.6010602@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964795AbVLNPQ3@vger.kernel.org>
In-Reply-To: <43A03568.6010602@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Knut Petersen <Knut_Petersen@t-online.de>, Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Antonino A. Daplas wrote:
> Knut Petersen wrote:
> 
> Wrong boolean check?  Should be if (vesafb & 4). Or might as
> well get rid of this check, it's redundant.
> 
>> +        release_mem_region(info->fix.smem_start,
>> +                   info->fix.smem_len);
>>     iounmap(io_virt);
>>  errout_mmio_remap:
>>     release_mem_region(info->fix.mmio_start,
>>                info->fix.mmio_len);
>>  errout_mmio_reqmem:
>> -//    release_region(0x3c0,32);
>> +    if (!(vesafb & 1))
>> +        release_region(0x3c0,32);
>>  errout_enable:
>> +    kfree(info->pixmap.addr);
>> + errout_alloc_pixmap:
>>     framebuffer_release(info);
>> - errout_alloc:
>> + errout_alloc_info:
>>     output("CyblaFB version %s aborting init.\n",VERSION);
>>     return -ENODEV;
>> }
>> @@ -1359,9 +1468,15 @@ static void __devexit cybla_pci_remove(s
>>     unregister_framebuffer(info);
>>     iounmap(io_virt);
>>     iounmap(info->screen_base);
>> -    release_mem_region(info->fix.smem_start,info->fix.smem_len);
>> +    if (!(vesafb & 4))
> 
> Shouldn't this be if (vesafb & 4)?
> 
>> +        release_mem_region(info->fix.smem_start,info->fix.smem_len);
>>     release_mem_region(info->fix.mmio_start,info->fix.mmio_len);
>>     fb_dealloc_cmap(&info->cmap);
>> +    if (!(vesafb & 2))
> 
> and this...
> 
>> +        release_region(GEBase,0x100);
>> +    if (!(vesafb & 1))
> 
> and this...?
> 

Disregard the last comments, you're right.

Tony
