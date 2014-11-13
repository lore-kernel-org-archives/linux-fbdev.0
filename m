From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 13 Nov 2014 14:46:28 +0000
Subject: Re: [linux-sunxi] Re: [PATCH v3 1/4] dt-bindings: simplefb: Specify node location and handoff relate
Message-Id: <5464C444.4050101@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415885645-24613-1-git-send-email-hdegoede@redhat.com>
 <5464C026.7030300@ti.com>
In-Reply-To: <5464C026.7030300@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 11/13/2014 03:28 PM, Tomi Valkeinen wrote:
> On 13/11/14 15:34, Hans de Goede wrote:
> 
>> +chosen {
>> +	framebuffer0: framebuffer@5fc00000 {
>>  		compatible = "simple-framebuffer";
>> -		reg = <0x1d385000 (1600 * 1200 * 2)>;
>> +		reg = <0x5fc00000 (4096 * 1024)>;
> 
> Was there a reason for this change?

I changed the node name to match the new bindings text which
specifies that the node name must be framebuffer@<address>,
while at it I've taken a real world address range.

I assume you refer to the bit where the size of the reg property
is changed ? That indeed is not really necessary.

Regards,

Hans
