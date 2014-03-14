From: Zhou Zhu <zzhu3@marvell.com>
Date: Fri, 14 Mar 2014 10:43:30 +0000
Subject: Re: [PATCH v2 4/4] video: mmp: add device tree support
Message-Id: <5322DD52.9070107@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389698184-28761-1-git-send-email-zzhu3@marvell.com> <1389698184-28761-5-git-send-email-zzhu3@marvell.com> <20140217143736.GC19308@e106331-lin.cambridge.arm.com> <CAJATT-5sQc7vsUhoFKdDnstqjj2R_yQ+Wk1NRf20UTM4-ndMSA@mail.gmail.com> <5316EF76.1050304@ti.com>
In-Reply-To: <5316EF76.1050304-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Zhou Zhu <zzhu84-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chao Xie <cxie4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Guoqing Li <ligq-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Lisa Du <cldu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yonghai Huang <huangyh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Hi, Tomi,

On 03/05/2014 05:33 PM, Tomi Valkeinen wrote:
> I would recommend using the same style that is used in the OMAP DSS, imx
> drm and exynos patches that are introducing DT support. They use ports
> and endpoints as defined in:
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/media/video-interfaces.txt
>
> with the addition of a simplified endpoint format, where the 'port' node
> is not required.
>
> To give an idea what it could look like, I've modified your example
> above. It's just a rough example, you should study and think how it best
> fits for mmp.
>
> You could use the same format for the internal connections also, but I
> didn't touch that. I think internal connections can as well be
> configured separately, in a custom format, because there's no need for
> external components to connect to the internal links.
>
> mmp-disp@d420b000 {
>      compatible = "marvell,mmp-disp";
>      reg = <0xd420b000 0x1fc>;
>      interrupts = <0 41 0x4>;
>
>      internal-connections {
>          pipe1: pn-path {
>          input = "panel-graphic";
>          output = &disp_out;
>          }
>      }
>
> 	disp_out: endpoint {
> 		remote-endpoint = <&panel_in>;
> 		marvell,rbswap;
> 		marvell,spi;
> 	};
>
>      status = "okay";
> }
>
> panel-xxx {
> 	properties;
>
> 	panel_in: endpoint {
> 		remote-endpoint = <&disp_out>;
> 	};
> };
>
>   Tomi
>
>
Thank you! I will update patches according to this layout later.


-- 
Thanks,
-Zhou
