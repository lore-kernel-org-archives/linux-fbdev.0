From: Julia Lawall <julia.lawall@lip6.fr>
Date: Sat, 11 Mar 2017 09:25:23 +0000
Subject: Re: [Outreachy kernel] [PATCH] staging: sm750fb: function prototype argument should have an identifi
Message-Id: <alpine.DEB.2.20.1703111021450.2202@hadrien>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+XqjF_k+MyLno8O=oX2mB808uPz5SBmuFsgEu3jM+2Qo8RUMw@mail.gmail.com>
In-Reply-To: <CA+XqjF_k+MyLno8O=oX2mB808uPz5SBmuFsgEu3jM+2Qo8RUMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: outreachy-kernel@googlegroups.com, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

This is the patch that I previously commented on.  Thus the subject line
should contain v2.  Please try to remember to do this every time.  It is
very confusing to see something one thinks one has already seen with no
version information.  There should also be a description of the change
since the previous version under the ---.

julia

On Sat, 11 Mar 2017, Arushi Singhal wrote:

>
> function prototype arguments like 'struct vb_device_info *','unsigned
> long' etc. should have an identifier name.
>
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_display.h | 2 +-
>  drivers/staging/sm750fb/ddk750_mode.h    | 2 +-
>  drivers/staging/sm750fb/ddk750_power.h   | 2 +-
>  drivers/staging/sm750fb/sm750.h          | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/sm750fb/ddk750_display.h b/drivers/staging/sm750fb/ddk750_display.h
> index e2a3f84ca4c5..609bf742efff 100644
> --- a/drivers/staging/sm750fb/ddk750_display.h
> +++ b/drivers/staging/sm750fb/ddk750_display.h
> @@ -102,6 +102,6 @@ typedef enum _disp_output_t {
>  }
>  disp_output_t;
>
> -void ddk750_setLogicalDispOut(disp_output_t);
> +void ddk750_setLogicalDispOut(disp_output_t output);
>
>  #endif
> diff --git a/drivers/staging/sm750fb/ddk750_mode.h b/drivers/staging/sm750fb/ddk750_mode.h
> index 2183e664cf4b..6d204b8b4a01 100644
> --- a/drivers/staging/sm750fb/ddk750_mode.h
> +++ b/drivers/staging/sm750fb/ddk750_mode.h
> @@ -34,6 +34,6 @@ typedef struct _mode_parameter_t {
>  }
>  mode_parameter_t;
>
> -int ddk750_setModeTiming(mode_parameter_t *, clock_type_t);
> +int ddk750_setModeTiming(mode_parameter_t *parm, clock_type_t clock);
>
>  #endif
> diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
> index ec0b99d6a7ad..44c4fc587e96 100644
> --- a/drivers/staging/sm750fb/ddk750_power.h
> +++ b/drivers/staging/sm750fb/ddk750_power.h
> @@ -14,7 +14,7 @@ DPMS_t;
>  	       (peek32(MISC_CTRL) & ~MISC_CTRL_DAC_POWER_OFF) | (off)); \
>  }
>
> -void ddk750_set_dpms(DPMS_t);
> +void ddk750_set_dpms(DPMS_t state);
>  void sm750_set_power_mode(unsigned int powerMode);
>  void sm750_set_current_gate(unsigned int gate);
>
> diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
> index 306711ed55f9..5ea455dee949 100644
> --- a/drivers/staging/sm750fb/sm750.h
> +++ b/drivers/staging/sm750fb/sm750.h
> @@ -184,7 +184,7 @@ static inline unsigned long ps_to_hz(unsigned int psvalue)
>  }
>
>  int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev);
> -int hw_sm750_inithw(struct sm750_dev*, struct pci_dev *);
> +int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev);
> -void hw_sm750_initAccel(struct sm750_dev *);
> +void hw_sm750_initAccel(struct sm750_dev *hw_sm750_initAccel);
>  int hw_sm750_deWait(void);
>  int hw_sm750le_deWait(void);
> --
> 2.11.0
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/CA%2BXqjF_k%2BMyLno8O%3DoX2mB808uPz5SBmuFsgEu3jM%2B2Qo8RUMw%40mail.gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
>
