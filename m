From: Zhou Zhu <zzhu84@gmail.com>
Date: Tue, 04 Mar 2014 11:28:57 +0000
Subject: Re: [PATCH v2 4/4] video: mmp: add device tree support
Message-Id: <CAJATT-5sQc7vsUhoFKdDnstqjj2R_yQ+Wk1NRf20UTM4-ndMSA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389698184-28761-1-git-send-email-zzhu3@marvell.com>
	<1389698184-28761-5-git-send-email-zzhu3@marvell.com>
	<20140217143736.GC19308@e106331-lin.cambridge.arm.com>
In-Reply-To: <20140217143736.GC19308-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Zhou Zhu <zzhu3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chao Xie <chao.xie-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Guoqing Li <ligq-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Lisa Du <cldu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, huangyh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org

Hi, Tomi and Mark,

On Mon, Feb 17, 2014 at 10:37 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Jan 14, 2014 at 11:16:24AM +0000, Zhou Zhu wrote:
> > add device tree support for mmp fb/controller
> > the description of DT config is at
> > Documentation/devicetree/bindings/fb/mmp-disp.txt
> >
> > Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
> > ---
> >  Documentation/devicetree/bindings/fb/mmp-disp.txt |   60 ++++++++
> >  drivers/video/mmp/fb/mmpfb.c                      |   73 ++++++----
> >  drivers/video/mmp/hw/mmp_ctrl.c                   |  160 ++++++++++++++++-----
> >  3 files changed, 235 insertions(+), 58 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/fb/mmp-disp.txt


Thank you very much for your review! I am trying to update the code
according to your comments.

We have reviewed the dts and removed many software settings and
not-used settings - for example, we unpacked path-config/link-config
and removed some configures that we will never change.
Also we removed fb settings which is considered as software.

Would you please give us some feedbacks if we adjust our dts into follow style?
As there might be big changes on the code structures, I would update
the code after this dts layout is considered as "right".

mmp-disp@d420b000 {
    compatible = "marvell,mmp-disp";
    reg = <0xd420b000 0x1fc>;
    interrupts = <0 41 0x4>;

    internal-connections {
        pipe1: pn-path {
        input = "panel-graphic"; //panel-graphic is the overlay name in spec.
        output = &parallel;
        }
    }
    ports{
        parallel: parallel {
            marvell,rbswap;
            marvell,spi;
        }
    }
    status = "okay";
}

panel-xxx {
    properties;
    connection = &parallel;
}

-- 
Thanks,
-Zhou
