From: Archit Taneja <a0393947@ti.com>
Date: Mon, 21 May 2012 08:26:16 +0000
Subject: Re: [PATCH] OMAPDSS: DSI: Support command mode interleaving during video mode blanking periods
Message-Id: <4FB9F958.7080600@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1337061738-32488-1-git-send-email-archit@ti.com> <1337348396.2607.19.camel@deskari>
In-Reply-To: <1337348396.2607.19.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Friday 18 May 2012 07:09 PM, Tomi Valkeinen wrote:
> Hi,
>
> On Tue, 2012-05-15 at 11:32 +0530, Archit Taneja wrote:
>> DSI supports interleaving of command mode packets during the HSA, HFP, HBP and
>> BLLP blanking intervals in a video mode stream. This is useful as a user may
>> want to read or change the configuration of a panel without stopping the video
>> stream.
>>
>> On OMAP DSI, we can queue HS or LP command mode packets in the TX FIFO, and
>> the DSI HW takes care of interleaving this data during the one of the blanking
>> intervals. The DSI HW needs to be programmed with the maximum amount of data
>> that can be interleaved in a particular blanking period. A blanking period
>> cannot be used to send command mode data for it's complete duration, there is
>> some amount of time required for the DSI data and clock lanes to transition
>> to the desired LP or HS state.
>>
>> Based on the state of the lanes at the beginning and end of the blanking period,
>> we have different scenarios, with each scenario having a different value of time
>> required to transition to HS or LP. Refer to the section 'Interleaving Mode' in
>> OMAP TRM for more info on the scenarios and the equations to calculate the time
>> required for HS or LP transitions.
>>
>> We use the scenarios which takes the maximum time for HS or LP transition, this
>> gives us the minimum amount of time that can be used to interleave command mode
>> data. The amount of data that can be sent during this minimum time is calculated
>> for command mode packets both in LP and HS. These are written to the registers
>> DSI_VM_TIMING4 to DSI_VM_TIMING6.
>>
>> The calculations don't take into account the time required of transmitting BTA
>> when doing a DSI read, or verifying if a DSI write went through correctly. Until
>> these latencies aren't considered, the behaviour of DSI is unpredictable when
>> a BTA is interleaved during a blanking period. Enhancement of these calculations
>> is a TODO item.
>
> The code in dsi_config_cmd_mode_interleaving() looks a bit long and
> confusing, but I don't think it's trivial to simplify it. There's just
> so many variables to consider.

There is a little optimisation done in the code to not calculate the 
interleaving parameter for a blanking period which is not used for 
interleaving. Checks like below are done for that:

	if(!hsa_blanking_mode) {
		...
	}

	if (!hfp_blanking_mode) {
		...
	}

	...

We could remove this, as the computation is just done once and there 
seems to be no side effects to write interleaving parameters for a 
blanking period not used for interleaving. But it won't make much 
function much simpler.

>
> In the future I think we should store the DSI configurations into
> memory, so that we don't need to parse the hardware registers to find
> out things like DSI timings.

Yes, I'll do this clean up sometime soon.

Archit
