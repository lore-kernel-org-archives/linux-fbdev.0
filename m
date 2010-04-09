From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [PATCH 05/16] viafb: Determine type of 2D engine and store it
 in chip_info
Date: Fri, 09 Apr 2010 22:34:16 +0200
Message-ID: <4BBF8F48.2070902@gmx.de>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>	<1270746946-12467-6-git-send-email-corbet@lwn.net>	<4BBE9CFC.2020804@gmx.de> <20100409141127.42e4e1fa@bike.lwn.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100409141127.42e4e1fa@bike.lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

Jonathan Corbet schrieb:
> On Fri, 09 Apr 2010 05:20:28 +0200
> Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
> 
>> Just a minor nit:
>> Could we change the default so that if someone adds support for a new 
>> IGP (and misses this function) we default to either the newest or 
>> preferably to none? I've just seen too much poorly maintained code in 
>> this driver and defaulting to the oldest is hence a bad idea.
>> Otherwise it's fine.
> 
> That would require making an exhaustive list of older chipset types.
> It could probably be inferred through inspection of the code, but I
> worry about making assumptions in this area...

Such list already exists. gfx_chip_name = pdi->driver_data in hw.c (and 
only there) so what is needed is the list viafb_pci_table in viafbdev.c 
(relatively at the end) of all chips:
UNICHROME_CLE266
UNICHROME_PM800
UNICHROME_K400
UNICHROME_K800
UNICHROME_CN700
UNICHROME_K8M890
UNICHROME_CX700
UNICHROME_P4M900
UNICHROME_CN750
UNICHROME_VX800
UNICHROME_VX855

Would appreciate it if you could use this info.


Thanks,

Florian Tobias Schandinat
