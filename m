From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 26 Aug 2014 09:02:55 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <53FC4D3F.3050407@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-5-git-send-email-libv@skynet.be>	<53EB9471.3090204@wwwdotorg.org>	<20140813170106.GT15297@lukather>	<20140825121228.GB4163@ulmo.nvidia.com>	<20140825124410.GZ15297@lukather>	<20140825133953.GJ4163@ulmo.nvidia.com>	<53FB3E7F.4000503@redhat.com>	<20140825141600.GA14763@ulmo.nvidia.com>	<CAKON4OyjJ+QcBGOzrUDH9J+DxBEKLmXeOcnUyOHHHV_DtCG0zA@mail.gmail.com>	<53FB47B8.2090104@redhat.com>	<20140825151255.GA14967@ulmo.nvidia.com>
 <CAKON4OzR=JACaVE2ATm6n95LCTbH2rXBzG_ExkD1kO8Qzzf1CA@mail.gmail.com>
In-Reply-To: <CAKON4OzR=JACaVE2ATm6n95LCTbH2rXBzG_ExkD1kO8Qzzf1CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 08/25/2014 05:49 PM, jonsmirl@gmail.com wrote:
> On Mon, Aug 25, 2014 at 11:12 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
>> On Mon, Aug 25, 2014 at 04:27:04PM +0200, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 08/25/2014 04:23 PM, jonsmirl@gmail.com wrote:
>>>> On Mon, Aug 25, 2014 at 10:16 AM, Thierry Reding
>>>> <thierry.reding@gmail.com> wrote:
>>>>> On Mon, Aug 25, 2014 at 03:47:43PM +0200, Hans de Goede wrote:
>>>>>> On 08/25/2014 03:39 PM, Thierry Reding wrote:
>>>>>>> On Mon, Aug 25, 2014 at 02:44:10PM +0200, Maxime Ripard wrote:
>>>>>>>> On Mon, Aug 25, 2014 at 02:12:30PM +0200, Thierry Reding wrote:
>>>>>>>>> On Wed, Aug 13, 2014 at 07:01:06PM +0200, Maxime Ripard wrote:
>>>>>>>>>> On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
>>>>>>>>> [...]
>>>>>>>>>>> If not, perhaps the clock driver should force the clock to be
>>>>>>>>>>> enabled (perhaps only if the DRM/KMS driver isn't enabled?).
>>>>>>>>>>
>>>>>>>>>> I'm sorry, but I'm not going to take any code that will do that in our
>>>>>>>>>> clock driver.
>>>>>>>>>>
>>>>>>>>>> I'm not going to have a huge list of ifdef depending on configuration
>>>>>>>>>> options to know which clock to enable, especially when clk_get should
>>>>>>>>>> have the consumer device as an argument.
>>>>>>>>>
>>>>>>>>> Are you saying is that you want to solve a platform-specific problem by
>>>>>>>>> pushing code into simple, generic drivers so that your platform code can
>>>>>>>>> stay "clean"?
>>>>>>>>
>>>>>>>> Are you saying that this driver would become "dirty" with such a patch?
>>>>>>>
>>>>>>> Yes. Others have said the same and even provided alternative solutions
>>>>>>> on how to solve what's seemingly a platform-specific problem in a
>>>>>>> platform-specific way.
>>>>>>
>>>>>> This is not platform specific, any platform with a complete clock driver
>>>>>> will suffer from the same problem (the clock driver disabling unclaimed
>>>>>> ahb gates, and thus killing the video output) if it wants to use simplefb
>>>>>> for early console support.
>>>>>
>>>>> It is platform specific in that your platform may require certain clocks
>>>>> to remain on. The next platform may require power domains to remain on
>>>>> during boot and yet another one may rely on regulators to stay on during
>>>>> boot. By your argument simplefb will need to be taught to handle pretty
>>>>> much every type of resource that the kernel has.
>>>>
>>>> Why can't simplefb be a driver library that is called from a device
>>>> specific device driver that only claims the clocks (or regulators)?
>>>> Then build all of these device specific drivers into the generic ARM
>>>> kernel. They will be quite small since all they do is claim the clocks
>>>> (or regulator).  Maybe we can even figure out some protocol for
>>>> removing the unused ones from memory later.
>>>>
>>>> Later during the boot process the device specific driver can load its
>>>> KMS code which has also been implemented as a driver library. Maybe
>>>> use E_PROBE_DEFER to do this. Match on the device ID, claim the
>>>> clocks, defer until the full KMS library can be loaded.
>>>
>>> There is no need for all this complexity, all that is needed is for the
>>> simplefb driver to be thought to claim + enable any clocks listed in
>>> its dt node.
>>
>> Out of curiosity, how does this work in practice? How does the
>> bootloader create this entry? Does it scan the DT to see which clocks
>> the real hardware device references and then simply copies them to the
>> simplefb node?
> 
> That's why this is such a problem. There is a general rule in Linux -
> one device, one driver.

A general rule with exceptions such as, drumroll ... , video devices,
e.g. efifb vs kms drivers are the exact same thing, or good old
vgacon vs kms drivers.

Or any other special firmware interfaces for early output (be it serial
or video) vs a later loaded / initialized more complete hardware specific
driver.

Also in the usb world there are quite a few examples where your once
device one driver rule does not hold either, but that is not really
relevant.

Regards,

Hans
