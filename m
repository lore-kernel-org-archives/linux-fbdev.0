From: Alex Courbot <acourbot@nvidia.com>
Date: Wed, 30 Jan 2013 07:01:48 +0000
Subject: Re: [RFC 3/4] drm: tegra: use the Common Display Framework
Message-Id: <5108C55C.30104@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359514939-15653-1-git-send-email-acourbot@nvidia.com> <1359514939-15653-4-git-send-email-acourbot@nvidia.com> <5108C298.1000500@gmail.com>
In-Reply-To: <5108C298.1000500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Zhang <nvmarkzhang@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Thierry Reding <thierry.reding@avionic-design.de>, Stephen Warren <swarren@wwwdotorg.org>, Mark Zhang <markz@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "gnurou@gmail.com" <gnurou@gmail.com>

On 01/30/2013 03:50 PM, Mark Zhang wrote:
>> @@ -147,6 +148,9 @@ struct tegra_output {
>>
>>   	struct drm_encoder encoder;
>>   	struct drm_connector connector;
>> +	struct display_entity this;
>> +	struct display_entity *output;
>
> Could you pick up a somewhat meaningful name? You know, there are too
> many variables with name "drm/connector/output/encoder"... :)

Well, it's supposed to be abstract. From the CDF point of view it could 
be anything besides a panel. I know this makes it an output of an 
output, but I can't think of anything better right now.

>> +		if (entity->dev && entity->dev->of_node = pnode) {
>> +			dev_dbg(output->dev, "connecting panel\n");
>> +			output->output = display_entity_get(entity);
>> +			display_entity_connect(&output->this, output->output);
>> +		}
>> +		of_node_put(pnode);
>> +
>> +		break;
>> +
>> +	case DISPLAY_ENTITY_NOTIFIER_DISCONNECT:
>> +		if (!output->output || output->output != entity)
>> +			break;
>> +
>> +		dev_dbg(output->dev, "disconnecting panel\n");
>> +		display_entity_disconnect(&output->this, output->output);
>> +		output->output = NULL;
>> +		display_entity_put(&output->this);
>
> No "display_entity_get" for "output->this", so I don't think we need
> "display_entity_put" here. If you register this entity with "release"
> callback and you wanna release "output->this", call the "release"
> function manually.

Oh, this was supposed to be called on output->output actually, to 
balance the display_entity_get() of the connect event. Thanks for 
catching this.

>> +	/* register display entity */
>> +	memset(&output->this, 0, sizeof(output->this));
>> +	output->this.dev = drm->dev;
>
> Use "output->dev" here. Actually the device you wanna register it to
> display entity is the "encoder"(in drm terms), not "drm->dev". If we use
> "drm->dev" here, we will have all same device for all encoders(HDMI,
> DSI...).

Yes, that's absolutely right.

>> +	/* register display notifier */
>> +	output->display_notifier.dev = NULL;
>
> Set "display_notifier.dev" to NULL makes we have to compare with every
> display entity, just like what you do in "display_notify_callback":
>
> entity->dev && entity->dev->of_node = pnode
>
> So can we get the "struct device *" of panel here? Seems currently the
> "of" framework doesn't allow "device_node -> device".

Nope. AFAICT the device might not be instanciated at this point. We 
become aware of it for the first time in the callback function. We also 
don't want to defer probing until the panel is parsed first, since the 
panel might also depend on resources of the display device.

Thanks,
Alex.

