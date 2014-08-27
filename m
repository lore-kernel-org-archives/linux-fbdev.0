From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 27 Aug 2014 12:50:18 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <53FDD40A.3040106@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825133953.GJ4163@ulmo.nvidia.com>	<53FB3E7F.4000503@redhat.com>	<20140825141600.GA14763@ulmo.nvidia.com>	<20140825145854.GA15297@lukather>	<20140825150501.GE14763@ulmo.nvidia.com>	<20140825152232.GE15297@lukather>	<20140826080432.GD17263@ulmo>	<20140826135341.GM15297@lukather>	<20140826143550.GB3027@ulmo>	<53FCE704.4030103@redhat.com>	<20140827093121.GA23186@ulmo>	<53FDB46C.5010609@redhat.com>
 <CAKON4Owj=b7r_iuOOrr_5R++oSbxqF0G0i4puFz7aTaUF+weuw@mail.gmail.com>
In-Reply-To: <CAKON4Owj=b7r_iuOOrr_5R++oSbxqF0G0i4puFz7aTaUF+weuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 08/27/2014 02:44 PM, jonsmirl@gmail.com wrote:

<snip>

>> 1) Serving as *the* fb until a kms driver is present
> 
> Why can't we whip together a real device specific fbdev driver and
> quit trying to run without a device specific driver in place? History
> has shown that to be bad idea except during early boot when there
> isn't a choice.

Writing a kms driver and getting it upstream is not a simple task, and
starting with a too limited implementation is dangerous as we need to get
the devicetree binding first from the get go.

IOW this is not really a realistic answer to problem 1.

<snip>

>> 2) Allowing for output of early kernel boot messages.
> 
> For this to work the kernel needs to know two things - address of the
> framebuffer and the x/y layout. Then just nuke this display when the
> kernel finishes the boot process.

Please read my earlier mails on how completely flawed it is to write
"when the kernel finishes the boot process". The problem is that there
is no way to really determine when this happens.

Regards,

Hans

