From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 17 Oct 2013 12:17:17 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <3768216.eiA2v5KI6a@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2515265.AjPQXgySzm"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com> <4885946.7Zgjf9zNXx@avalon> <525FD12D.3000200@ti.com>
In-Reply-To: <525FD12D.3000200-l0cyMroinI0@public.gmane.org>
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--nextPart2515265.AjPQXgySzm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Tomi,

On Thursday 17 October 2013 14:59:41 Tomi Valkeinen wrote:
> On 17/10/13 14:51, Laurent Pinchart wrote:
> >> I'm not sure if there's a specific need for the port or endpoint nodes
> >> in cases like the above. Even if we have common properties describing
> >> the endpoint, I guess they could just be in the parent node.
> >> 
> >> panel {
> >> 	remote = <&dc>;
> >> 	common-video-property = <asd>;
> >> };
> >> 
> >> The above would imply one port and one endpoint. Would that work? If we
> >> had a function like parse_endpoint(node), we could just point it to
> >> either a real endpoint node, or to the device's node.
> > 
> > You reference the display controller here, not a specific display
> > controller output. Don't most display controllers have several outputs ?
> 
> Sure. Then the display controller could have more verbose description.
> But the panel could still have what I wrote above, except the 'remote'
> property would point to a real endpoint node inside the dispc node, not
> to the dispc node.
> 
> This would, of course, need some extra code to handle the different
> cases, but just from DT point of view, I think all the relevant
> information is there.

There's many ways to describe the same information in DT. While we could have 
DT bindings that use different descriptions for different devices and still 
support all of them in our code, why should we opt for that option that will 
make the implementation much more complex when we can describe connections in 
a simple and generic way ?

-- 
Regards,

Laurent Pinchart

--nextPart2515265.AjPQXgySzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSX9VNAAoJEIkPb2GL7hl1F4MIAILdvdwkl9Lbry1tum9SEmPn
RpRDoTXa/E4DyHO7ydp9Xi13BpYzL67RvRahubXRJZlKEEElVY3ijtoPwXiKWxMv
UwaLEjF30T2xPNF35meULnaEnI82aAF8j3wp10RlbuQPbewRsdDiAvEdrgBqCnvg
or16m6K9htA1HrSvExPCFUgt4HB6mOTr7QM2S3E0DsSZ1HPWN/QXfZ8PdV9ULUqw
LG6Gz7b5OtU5DxMwDXhnnU5A+2R326l7v23fWcC9iYKh/sL5AVQLUqoPAxIRw7St
LH7UxxENRzmd0tmaLLBixpvFnxzxl61kx2gFLy2wBhXHuziGSII5/3A7z2dr/Dk=
=8j1f
-----END PGP SIGNATURE-----

--nextPart2515265.AjPQXgySzm--

