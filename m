From: Michal Simek <michal.simek@xilinx.com>
Date: Thu, 03 Oct 2013 09:13:05 +0000
Subject: Re: [PATCH] amba: Ensure drvdata is NULL
Message-Id: <d5a0aab9-f023-4464-b4a1-f7055e6c82d5@CO9EHSMHS010.ehs.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1b2479137287fa8dfda3089ca0cb9fba8c4b1f1d.1380524337.git.michal.simek@xilinx.com>
 <20131002202521.GU12758@n2100.arm.linux.org.uk>
In-Reply-To: <20131002202521.GU12758@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 10/02/2013 10:25 PM, Russell King - ARM Linux wrote:
> On Mon, Sep 30, 2013 at 08:59:06AM +0200, Michal Simek wrote:
>> This patch is inpired by the patch for drvdata
>> "device-core: Ensure drvdata = NULL when no driver is bound"
>> (sha1: 0998d0631001288a5974afc0b2a5f568bcdecb4d)
>>
>> Also it fixes all occurences in drivers.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>> This patch has been sent as RFC in this thread.
>> http://lkml.org/lkml/2013/9/4/393
> 
> Why not have the driver core do this?  Then it gets applied to all bus
> types uniformly.

ok - I have checked that path and it should be already done
in really_probe function which calls amba_probe() and then driver probe function.

It means that the patch should contain just "amba_set_drvdata(dev, NULL);"
removal and not touching bus.c file.

Thanks,
Michal


