From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 17 Oct 2013 11:51:44 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <4885946.7Zgjf9zNXx@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart4432037.AtEoIFuDXi"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com> <12566222.aRYc4MDoOm@avalon> <525FCB95.6070401@ti.com>
In-Reply-To: <525FCB95.6070401-l0cyMroinI0@public.gmane.org>
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--nextPart4432037.AtEoIFuDXi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Tomi,

On Thursday 17 October 2013 14:35:49 Tomi Valkeinen wrote:
> On 17/10/13 14:02, Laurent Pinchart wrote:
> >> Okay, so if I understand correctly, translating those bindings to panel
> >> 
> >> nodes would look somewhat like this:
> >> 	dc: display-controller {
> >> 		ports {
> >> 			port@0 {
> >> 				remote-endpoint = <&panel>;
> >> 			};
> >> 		};
> >> 	};
> >> 	
> >> 	panel: panel {
> >> 		ports {
> >> 			port@0 {
> >> 				remote-endpoint = <&dc>;
> >> 			};
> >> 		};
> >> 	};
> >> 
> >> The above leaves out any of the other, non-relevant properties. Does
> >> that sound about right?
> > 
> > Yes it does.
> 
> It does?
> 
> Shouldn't it be something like:
> 
> panel {
> 	ports {
> 		port@0 {
> 			endpoint@0 {
> 				remote = <&dc>;
> 			};
> 		};
> 	};
> };
> 
> And simplified:
> 
> panel {
> 	port {
> 		endpoint@0 {
> 			remote = <&dc>;
> 		};
> 	};
> };
> 
> You do need a node for the endpoint, a remote-endpoint property is not
> enough.

My bad, you'r absolutely right. More sleep is needed.

(And while we're at it, the remote-endpoint properties must point to an 
endpoint, not the device DT node.

> > Please note that, when a device has as single port, the ports node can be
> > omitted, and the port doesn't need to be numbered. You would then end up
> > with> 
> >  	dc: display-controller {
> > 		port {
> > 			remote-endpoint = <&panel>;
> >  		};
> >  	};
> >  	
> >  	panel: panel {
> >  		port {
> >  			remote-endpoint = <&dc>;
> >  		};
> >  	};
> > 
> > I don't think there's a way to simplify it further.
> 
> I'm not sure if there's a specific need for the port or endpoint nodes
> in cases like the above. Even if we have common properties describing
> the endpoint, I guess they could just be in the parent node.
> 
> panel {
> 	remote = <&dc>;
> 	common-video-property = <asd>;
> };
> 
> The above would imply one port and one endpoint. Would that work? If we
> had a function like parse_endpoint(node), we could just point it to
> either a real endpoint node, or to the device's node.

You reference the display controller here, not a specific display controller 
output. Don't most display controllers have several outputs ?

-- 
Regards,

Laurent Pinchart

--nextPart4432037.AtEoIFuDXi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSX89VAAoJEIkPb2GL7hl11jsH/3IAiFudPgna8DfAskSzxHnT
KWSvWxqUm7bbVGikNJdTzfRfpEzwBgtON4cqeGKAoTThYaKW7C61POB2KMqZHmjr
68hCcEwKOvJDXIvwUq8VeakxwCKqmCEHCSwoDVXk4ukIn8PfIUI5jRYhTqtZZ8SE
FQaG5lXTPNZmc/HbkF9Ro/B0gMFPQio0U5d4amVGo8HLDVfXKappHLAIuZwRYApP
pNJt+Nbq8/INoM4bDKsDPPs56THPY/Src2RucKrHOLqc7pSOoE200i/CKVjnOMGe
C2/s3IXUMgY23nYWJS32slmZTnldRs7OqUgpoaoicJTojWHNxH5WWpWCBDzzcbQ=
=hv2m
-----END PGP SIGNATURE-----

--nextPart4432037.AtEoIFuDXi--

