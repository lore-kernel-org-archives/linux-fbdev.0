From: Zhang Rui <rui.zhang@intel.com>
Date: Thu, 21 Dec 2017 00:47:51 +0000
Subject: Re: [-next PATCH 2/4] treewide: Use DEVICE_ATTR_RW
Message-Id: <1513817271.2592.2.camel@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1513706701.git.joe@perches.com>
 <cd38f14f06e1f447b3159ffe8c69c0df8241bb6e.1513706701.git.joe@perches.com>
In-Reply-To: <cd38f14f06e1f447b3159ffe8c69c0df8241bb6e.1513706701.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Joe Perches <joe@perches.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, James Smart <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>, Eduardo Valentin <edubezval@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mathias Nyman <mathias.nyman@intel.com>, Felipe Balbi <balbi@kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, David Airlie <airlied@linux.ie>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Takashi Iwai <tiwai@suse.com>, linux-s390@vger.kernel.org, linux-omap@vger.kernel.org, "James E.J.
 Bottomley" <jejb@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, platform-driver-x86@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, intel-gfx@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Tue, 2017-12-19 at 10:15 -0800, Joe Perches wrote:
> Convert DEVICE_ATTR uses to DEVICE_ATTR_RW where possible.
> 
> Done with perl script:
> 
> $ git grep -w --name-only DEVICE_ATTR | \
>   xargs perl -i -e 'local $/; while (<>) {
> s/\bDEVICE_ATTR\s*\(\s*(\w+)\s*,\s*\(?(\s*S_IRUGO\s*\|\s*S_IWUSR|\s*S
> _IWUSR\s*\|\s*S_IRUGO\s*|\s*0644\s*)\)?\s*,\s*\1_show\s*,\s*\1_store\
> s*\)/DEVICE_ATTR_RW(\1)/g; print;}'
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/s390/kernel/topology.c          |  3 +--
>  arch/tile/kernel/sysfs.c             |  2 +-
>  drivers/gpu/drm/i915/i915_sysfs.c    |  6 ++---
>  drivers/platform/x86/compal-laptop.c | 18 +++++----------
>  drivers/s390/cio/device.c            |  2 +-
>  drivers/scsi/lpfc/lpfc_attr.c        | 43 ++++++++++++------------
> ------------
>  drivers/thermal/thermal_sysfs.c      |  9 ++++----

For the thermal part,
ACK-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui

>  drivers/tty/serial/sh-sci.c          |  2 +-
>  drivers/usb/host/xhci-dbgcap.c       |  2 +-
>  drivers/usb/phy/phy-tahvo.c          |  2 +-
>  drivers/video/fbdev/auo_k190x.c      |  4 ++--
>  drivers/video/fbdev/w100fb.c         |  4 ++--
>  lib/test_firmware.c                  | 14 +++++-------
>  lib/test_kmod.c                      | 14 +++++-------
>  sound/soc/omap/mcbsp.c               |  4 ++--
>  15 files changed, 49 insertions(+), 80 deletions(-)
> 
> diff --git a/arch/s390/kernel/topology.c
> b/arch/s390/kernel/topology.c
> index 4d5b65e527b5..4b6e0397f66d 100644
> --- a/arch/s390/kernel/topology.c
> +++ b/arch/s390/kernel/topology.c
> @@ -404,8 +404,7 @@ static ssize_t dispatching_store(struct device
> *dev,
>  	put_online_cpus();
>  	return rc ? rc : count;
>  }
> -static DEVICE_ATTR(dispatching, 0644, dispatching_show,
> -			 dispatching_store);
> +static DEVICE_ATTR_RW(dispatching);
>  
>  static ssize_t cpu_polarization_show(struct device *dev,
>  				     struct device_attribute *attr,
> char *buf)
> diff --git a/arch/tile/kernel/sysfs.c b/arch/tile/kernel/sysfs.c
> index 825867c53853..af5024f0fb5a 100644
> --- a/arch/tile/kernel/sysfs.c
> +++ b/arch/tile/kernel/sysfs.c
> @@ -184,7 +184,7 @@ static ssize_t hv_stats_store(struct device *dev,
>  	return n < 0 ? n : count;
>  }
>  
> -static DEVICE_ATTR(hv_stats, 0644, hv_stats_show, hv_stats_store);
> +static DEVICE_ATTR_RW(hv_stats);
>  
>  static int hv_stats_device_add(struct device *dev, struct
> subsys_interface *sif)
>  {
> diff --git a/drivers/gpu/drm/i915/i915_sysfs.c
> b/drivers/gpu/drm/i915/i915_sysfs.c
> index c74a20b80182..1d0ab8ff5915 100644
> --- a/drivers/gpu/drm/i915/i915_sysfs.c
> +++ b/drivers/gpu/drm/i915/i915_sysfs.c
> @@ -447,9 +447,9 @@ static ssize_t gt_min_freq_mhz_store(struct
> device *kdev,
>  
>  static DEVICE_ATTR(gt_act_freq_mhz, S_IRUGO, gt_act_freq_mhz_show,
> NULL);
>  static DEVICE_ATTR(gt_cur_freq_mhz, S_IRUGO, gt_cur_freq_mhz_show,
> NULL);
> -static DEVICE_ATTR(gt_boost_freq_mhz, S_IRUGO | S_IWUSR,
> gt_boost_freq_mhz_show, gt_boost_freq_mhz_store);
> -static DEVICE_ATTR(gt_max_freq_mhz, S_IRUGO | S_IWUSR,
> gt_max_freq_mhz_show, gt_max_freq_mhz_store);
> -static DEVICE_ATTR(gt_min_freq_mhz, S_IRUGO | S_IWUSR,
> gt_min_freq_mhz_show, gt_min_freq_mhz_store);
> +static DEVICE_ATTR_RW(gt_boost_freq_mhz);
> +static DEVICE_ATTR_RW(gt_max_freq_mhz);
> +static DEVICE_ATTR_RW(gt_min_freq_mhz);
>  
>  static DEVICE_ATTR(vlv_rpe_freq_mhz, S_IRUGO, vlv_rpe_freq_mhz_show,
> NULL);
>  
> diff --git a/drivers/platform/x86/compal-laptop.c
> b/drivers/platform/x86/compal-laptop.c
> index 6bcb750e1865..4f9bc72f0584 100644
> --- a/drivers/platform/x86/compal-laptop.c
> +++ b/drivers/platform/x86/compal-laptop.c
> @@ -679,18 +679,12 @@ static int bat_writeable_property(struct
> power_supply *psy,
>  /* ======= */
>  /* Driver Globals */
>  /* ======= */
> -static DEVICE_ATTR(wake_up_pme,
> -		0644, wake_up_pme_show,		wake_up_pme_s
> tore);
> -static DEVICE_ATTR(wake_up_modem,
> -		0644, wake_up_modem_show,	wake_up_modem_store
> );
> -static DEVICE_ATTR(wake_up_lan,
> -		0644, wake_up_lan_show,	wake_up_lan_store);
> -static DEVICE_ATTR(wake_up_wlan,
> -		0644, wake_up_wlan_show,	wake_up_wlan_store);
> -static DEVICE_ATTR(wake_up_key,
> -		0644, wake_up_key_show,	wake_up_key_store);
> -static DEVICE_ATTR(wake_up_mouse,
> -		0644, wake_up_mouse_show,	wake_up_mouse_store
> );
> +static DEVICE_ATTR_RW(wake_up_pme);
> +static DEVICE_ATTR_RW(wake_up_modem);
> +static DEVICE_ATTR_RW(wake_up_lan);
> +static DEVICE_ATTR_RW(wake_up_wlan);
> +static DEVICE_ATTR_RW(wake_up_key);
> +static DEVICE_ATTR_RW(wake_up_mouse);
>  
>  static DEVICE_ATTR(fan1_input,  S_IRUGO, fan_show,          NULL);
>  static DEVICE_ATTR(temp1_input, S_IRUGO, temp_cpu,          NULL);
> diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
> index 75a245f38e2e..6eefb67b31f3 100644
> --- a/drivers/s390/cio/device.c
> +++ b/drivers/s390/cio/device.c
> @@ -600,7 +600,7 @@ static ssize_t vpm_show(struct device *dev,
> struct device_attribute *attr,
>  static DEVICE_ATTR(devtype, 0444, devtype_show, NULL);
>  static DEVICE_ATTR(cutype, 0444, cutype_show, NULL);
>  static DEVICE_ATTR(modalias, 0444, modalias_show, NULL);
> -static DEVICE_ATTR(online, 0644, online_show, online_store);
> +static DEVICE_ATTR_RW(online);
>  static DEVICE_ATTR(availability, 0444, available_show, NULL);
>  static DEVICE_ATTR(logging, 0200, NULL, initiate_logging);
>  static DEVICE_ATTR(vpm, 0444, vpm_show, NULL);
> diff --git a/drivers/scsi/lpfc/lpfc_attr.c
> b/drivers/scsi/lpfc/lpfc_attr.c
> index 797bb42a6306..95f7ba3c3f1a 100644
> --- a/drivers/scsi/lpfc/lpfc_attr.c
> +++ b/drivers/scsi/lpfc/lpfc_attr.c
> @@ -2519,8 +2519,7 @@ lpfc_soft_wwpn_store(struct device *dev, struct
> device_attribute *attr,
>  				"reinit adapter - %d\n", stat2);
>  	return (stat1 || stat2) ? -EIO : count;
>  }
> -static DEVICE_ATTR(lpfc_soft_wwpn, S_IRUGO | S_IWUSR,
> -		   lpfc_soft_wwpn_show, lpfc_soft_wwpn_store);
> +static DEVICE_ATTR_RW(lpfc_soft_wwpn);
>  
>  /**
>   * lpfc_soft_wwnn_show - Return the cfg soft ww node name for the
> adapter
> @@ -2583,8 +2582,7 @@ lpfc_soft_wwnn_store(struct device *dev, struct
> device_attribute *attr,
>  
>  	return count;
>  }
> -static DEVICE_ATTR(lpfc_soft_wwnn, S_IRUGO | S_IWUSR,
> -		   lpfc_soft_wwnn_show, lpfc_soft_wwnn_store);
> +static DEVICE_ATTR_RW(lpfc_soft_wwnn);
>  
>  /**
>   * lpfc_oas_tgt_show - Return wwpn of target whose luns maybe
> enabled for
> @@ -3102,8 +3100,7 @@ MODULE_PARM_DESC(lpfc_poll, "FCP ring polling
> mode control:"
>  		 " 1 - poll with interrupts enabled"
>  		 " 3 - poll and disable FCP ring interrupts");
>  
> -static DEVICE_ATTR(lpfc_poll, S_IRUGO | S_IWUSR,
> -		   lpfc_poll_show, lpfc_poll_store);
> +static DEVICE_ATTR_RW(lpfc_poll);
>  
>  int lpfc_no_hba_reset_cnt;
>  unsigned long lpfc_no_hba_reset[MAX_HBAS_NO_RESET] = {
> @@ -3336,8 +3333,7 @@ lpfc_nodev_tmo_set(struct lpfc_vport *vport,
> int val)
>  
>  lpfc_vport_param_store(nodev_tmo)
>  
> -static DEVICE_ATTR(lpfc_nodev_tmo, S_IRUGO | S_IWUSR,
> -		   lpfc_nodev_tmo_show, lpfc_nodev_tmo_store);
> +static DEVICE_ATTR_RW(lpfc_nodev_tmo);
>  
>  /*
>  # lpfc_devloss_tmo: If set, it will hold all I/O errors on devices
> that
> @@ -3386,8 +3382,7 @@ lpfc_devloss_tmo_set(struct lpfc_vport *vport,
> int val)
>  }
>  
>  lpfc_vport_param_store(devloss_tmo)
> -static DEVICE_ATTR(lpfc_devloss_tmo, S_IRUGO | S_IWUSR,
> -		   lpfc_devloss_tmo_show, lpfc_devloss_tmo_store);
> +static DEVICE_ATTR_RW(lpfc_devloss_tmo);
>  
>  /*
>   * lpfc_suppress_rsp: Enable suppress rsp feature is firmware
> supports it
> @@ -3580,8 +3575,7 @@ lpfc_restrict_login_set(struct lpfc_vport
> *vport, int val)
>  	return 0;
>  }
>  lpfc_vport_param_store(restrict_login);
> -static DEVICE_ATTR(lpfc_restrict_login, S_IRUGO | S_IWUSR,
> -		   lpfc_restrict_login_show,
> lpfc_restrict_login_store);
> +static DEVICE_ATTR_RW(lpfc_restrict_login);
>  
>  /*
>  # Some disk devices have a "select ID" or "select Target"
> capability.
> @@ -3695,8 +3689,7 @@ lpfc_topology_store(struct device *dev, struct
> device_attribute *attr,
>  }
>  
>  lpfc_param_show(topology)
> -static DEVICE_ATTR(lpfc_topology, S_IRUGO | S_IWUSR,
> -		lpfc_topology_show, lpfc_topology_store);
> +static DEVICE_ATTR_RW(lpfc_topology);
>  
>  /**
>   * lpfc_static_vport_show: Read callback function for
> @@ -3954,8 +3947,7 @@ lpfc_stat_data_ctrl_show(struct device *dev,
> struct device_attribute *attr,
>  /*
>   * Sysfs attribute to control the statistical data collection.
>   */
> -static DEVICE_ATTR(lpfc_stat_data_ctrl, S_IRUGO | S_IWUSR,
> -		   lpfc_stat_data_ctrl_show,
> lpfc_stat_data_ctrl_store);
> +static DEVICE_ATTR_RW(lpfc_stat_data_ctrl);
>  
>  /*
>   * lpfc_drvr_stat_data: sysfs attr to get driver statistical data.
> @@ -4194,8 +4186,7 @@ lpfc_link_speed_init(struct lpfc_hba *phba, int
> val)
>  	return -EINVAL;
>  }
>  
> -static DEVICE_ATTR(lpfc_link_speed, S_IRUGO | S_IWUSR,
> -		   lpfc_link_speed_show, lpfc_link_speed_store);
> +static DEVICE_ATTR_RW(lpfc_link_speed);
>  
>  /*
>  # lpfc_aer_support: Support PCIe device Advanced Error Reporting
> (AER)
> @@ -4288,8 +4279,7 @@ lpfc_aer_support_store(struct device *dev,
> struct device_attribute *attr,
>  	return rc;
>  }
>  
> -static DEVICE_ATTR(lpfc_aer_support, S_IRUGO | S_IWUSR,
> -		   lpfc_aer_support_show, lpfc_aer_support_store);
> +static DEVICE_ATTR_RW(lpfc_aer_support);
>  
>  /**
>   * lpfc_aer_cleanup_state - Clean up aer state to the aer enabled
> device
> @@ -4436,8 +4426,7 @@ LPFC_ATTR(sriov_nr_virtfn,
> LPFC_DEF_VFN_PER_PFN, 0, LPFC_MAX_VFN_PER_PFN,
>  	"Enable PCIe device SR-IOV virtual fn");
>  
>  lpfc_param_show(sriov_nr_virtfn)
> -static DEVICE_ATTR(lpfc_sriov_nr_virtfn, S_IRUGO | S_IWUSR,
> -		   lpfc_sriov_nr_virtfn_show,
> lpfc_sriov_nr_virtfn_store);
> +static DEVICE_ATTR_RW(lpfc_sriov_nr_virtfn);
>  
>  /**
>   * lpfc_request_firmware_store - Request for Linux generic firmware
> upgrade
> @@ -4611,8 +4600,7 @@ lpfc_fcp_imax_init(struct lpfc_hba *phba, int
> val)
>  	return 0;
>  }
>  
> -static DEVICE_ATTR(lpfc_fcp_imax, S_IRUGO | S_IWUSR,
> -		   lpfc_fcp_imax_show, lpfc_fcp_imax_store);
> +static DEVICE_ATTR_RW(lpfc_fcp_imax);
>  
>  /*
>   * lpfc_auto_imax: Controls Auto-interrupt coalescing values
> support.
> @@ -4772,8 +4760,7 @@ lpfc_fcp_cpu_map_init(struct lpfc_hba *phba,
> int val)
>  	return 0;
>  }
>  
> -static DEVICE_ATTR(lpfc_fcp_cpu_map, S_IRUGO | S_IWUSR,
> -		   lpfc_fcp_cpu_map_show, lpfc_fcp_cpu_map_store);
> +static DEVICE_ATTR_RW(lpfc_fcp_cpu_map);
>  
>  /*
>  # lpfc_fcp_class:  Determines FC class to use for the FCP protocol.
> @@ -4859,9 +4846,7 @@ lpfc_max_scsicmpl_time_set(struct lpfc_vport
> *vport, int val)
>  	return 0;
>  }
>  lpfc_vport_param_store(max_scsicmpl_time);
> -static DEVICE_ATTR(lpfc_max_scsicmpl_time, S_IRUGO | S_IWUSR,
> -		   lpfc_max_scsicmpl_time_show,
> -		   lpfc_max_scsicmpl_time_store);
> +static DEVICE_ATTR_RW(lpfc_max_scsicmpl_time);
>  
>  /*
>  # lpfc_ack0: Use ACK0, instead of ACK1 for class 2 acknowledgement.
> Value
> diff --git a/drivers/thermal/thermal_sysfs.c
> b/drivers/thermal/thermal_sysfs.c
> index fb80c96d8f73..c008af7fb480 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -398,14 +398,13 @@ create_s32_tzp_attr(offset);
>   */
>  static DEVICE_ATTR(type, 0444, type_show, NULL);
>  static DEVICE_ATTR(temp, 0444, temp_show, NULL);
> -static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show,
> policy_store);
> +static DEVICE_ATTR_RW(policy);
>  static DEVICE_ATTR(available_policies, S_IRUGO,
> available_policies_show, NULL);
> -static DEVICE_ATTR(sustainable_power, S_IWUSR | S_IRUGO,
> sustainable_power_show,
> -		   sustainable_power_store);
> +static DEVICE_ATTR_RW(sustainable_power);
>  
>  /* These thermal zone device attributes are created based on
> conditions */
> -static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
> -static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show,
> passive_store);
> +static DEVICE_ATTR_RW(mode);
> +static DEVICE_ATTR_RW(passive);
>  
>  /* These attributes are unconditionally added to a thermal zone */
>  static struct attribute *thermal_zone_dev_attrs[] = {
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-
> sci.c
> index d9f399c4e90c..7257c078e155 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1144,7 +1144,7 @@ static ssize_t rx_fifo_timeout_store(struct
> device *dev,
>  	return count;
>  }
>  
> -static DEVICE_ATTR(rx_fifo_timeout, 0644, rx_fifo_timeout_show,
> rx_fifo_timeout_store);
> +static DEVICE_ATTR_RW(rx_fifo_timeout);
>  
>  
>  #ifdef CONFIG_SERIAL_SH_SCI_DMA
> diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-
> dbgcap.c
> index 452df0f87d6e..a1ab8acf39ba 100644
> --- a/drivers/usb/host/xhci-dbgcap.c
> +++ b/drivers/usb/host/xhci-dbgcap.c
> @@ -920,7 +920,7 @@ static ssize_t dbc_store(struct device *dev,
>  	return count;
>  }
>  
> -static DEVICE_ATTR(dbc, 0644, dbc_show, dbc_store);
> +static DEVICE_ATTR_RW(dbc);
>  
>  int xhci_dbc_init(struct xhci_hcd *xhci)
>  {
> diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-
> tahvo.c
> index b3ce42edb373..7f7c5c82420d 100644
> --- a/drivers/usb/phy/phy-tahvo.c
> +++ b/drivers/usb/phy/phy-tahvo.c
> @@ -310,7 +310,7 @@ static ssize_t otg_mode_store(struct device
> *device,
>  
>  	return r;
>  }
> -static DEVICE_ATTR(otg_mode, 0644, otg_mode_show, otg_mode_store);
> +static DEVICE_ATTR_RW(otg_mode);
>  
>  static struct attribute *tahvo_attributes[] = {
>  	&dev_attr_vbus.attr,
> diff --git a/drivers/video/fbdev/auo_k190x.c
> b/drivers/video/fbdev/auo_k190x.c
> index 0d06038324e0..1e383c547633 100644
> --- a/drivers/video/fbdev/auo_k190x.c
> +++ b/drivers/video/fbdev/auo_k190x.c
> @@ -708,8 +708,8 @@ static ssize_t temp_show(struct device *dev,
> struct device_attribute *attr,
>  	return sprintf(buf, "%d\n", temp);
>  }
>  
> -static DEVICE_ATTR(update_mode, 0644, update_mode_show,
> update_mode_store);
> -static DEVICE_ATTR(flash, 0644, flash_show, flash_store);
> +static DEVICE_ATTR_RW(update_mode);
> +static DEVICE_ATTR_RW(flash);
>  static DEVICE_ATTR(temp, 0644, temp_show, NULL);
>  
>  static struct attribute *auok190x_attributes[] = {
> diff --git a/drivers/video/fbdev/w100fb.c
> b/drivers/video/fbdev/w100fb.c
> index d570e19a2864..035ff6e02894 100644
> --- a/drivers/video/fbdev/w100fb.c
> +++ b/drivers/video/fbdev/w100fb.c
> @@ -110,7 +110,7 @@ static ssize_t flip_store(struct device *dev,
> struct device_attribute *attr, con
>  	return count;
>  }
>  
> -static DEVICE_ATTR(flip, 0644, flip_show, flip_store);
> +static DEVICE_ATTR_RW(flip);
>  
>  static ssize_t w100fb_reg_read(struct device *dev, struct
> device_attribute *attr, const char *buf, size_t count)
>  {
> @@ -166,7 +166,7 @@ static ssize_t fastpllclk_store(struct device
> *dev, struct device_attribute *att
>  	return count;
>  }
>  
> -static DEVICE_ATTR(fastpllclk, 0644, fastpllclk_show,
> fastpllclk_store);
> +static DEVICE_ATTR_RW(fastpllclk);
>  
>  /*
>   * Some touchscreens need hsync information from the video driver to
> diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> index 64a4c76cba2b..964784dc1602 100644
> --- a/lib/test_firmware.c
> +++ b/lib/test_firmware.c
> @@ -359,7 +359,7 @@ static ssize_t config_name_show(struct device
> *dev,
>  {
>  	return config_test_show_str(buf, test_fw_config->name);
>  }
> -static DEVICE_ATTR(config_name, 0644, config_name_show,
> config_name_store);
> +static DEVICE_ATTR_RW(config_name);
>  
>  static ssize_t config_num_requests_store(struct device *dev,
>  					 struct device_attribute
> *attr,
> @@ -388,8 +388,7 @@ static ssize_t config_num_requests_show(struct
> device *dev,
>  {
>  	return test_dev_config_show_u8(buf, test_fw_config-
> >num_requests);
>  }
> -static DEVICE_ATTR(config_num_requests, 0644,
> config_num_requests_show,
> -		   config_num_requests_store);
> +static DEVICE_ATTR_RW(config_num_requests);
>  
>  static ssize_t config_sync_direct_store(struct device *dev,
>  					struct device_attribute
> *attr,
> @@ -411,8 +410,7 @@ static ssize_t config_sync_direct_show(struct
> device *dev,
>  {
>  	return test_dev_config_show_bool(buf, test_fw_config-
> >sync_direct);
>  }
> -static DEVICE_ATTR(config_sync_direct, 0644,
> config_sync_direct_show,
> -		   config_sync_direct_store);
> +static DEVICE_ATTR_RW(config_sync_direct);
>  
>  static ssize_t config_send_uevent_store(struct device *dev,
>  					struct device_attribute
> *attr,
> @@ -428,8 +426,7 @@ static ssize_t config_send_uevent_show(struct
> device *dev,
>  {
>  	return test_dev_config_show_bool(buf, test_fw_config-
> >send_uevent);
>  }
> -static DEVICE_ATTR(config_send_uevent, 0644,
> config_send_uevent_show,
> -		   config_send_uevent_store);
> +static DEVICE_ATTR_RW(config_send_uevent);
>  
>  static ssize_t config_read_fw_idx_store(struct device *dev,
>  					struct device_attribute
> *attr,
> @@ -445,8 +442,7 @@ static ssize_t config_read_fw_idx_show(struct
> device *dev,
>  {
>  	return test_dev_config_show_u8(buf, test_fw_config-
> >read_fw_idx);
>  }
> -static DEVICE_ATTR(config_read_fw_idx, 0644,
> config_read_fw_idx_show,
> -		   config_read_fw_idx_store);
> +static DEVICE_ATTR_RW(config_read_fw_idx);
>  
>  
>  static ssize_t trigger_request_store(struct device *dev,
> diff --git a/lib/test_kmod.c b/lib/test_kmod.c
> index 337f408b4de6..e372b97eee13 100644
> --- a/lib/test_kmod.c
> +++ b/lib/test_kmod.c
> @@ -694,8 +694,7 @@ static ssize_t config_test_driver_show(struct
> device *dev,
>  	return config_test_show_str(&test_dev->config_mutex, buf,
>  				    config->test_driver);
>  }
> -static DEVICE_ATTR(config_test_driver, 0644,
> config_test_driver_show,
> -		   config_test_driver_store);
> +static DEVICE_ATTR_RW(config_test_driver);
>  
>  static ssize_t config_test_fs_store(struct device *dev,
>  				    struct device_attribute *attr,
> @@ -726,8 +725,7 @@ static ssize_t config_test_fs_show(struct device
> *dev,
>  	return config_test_show_str(&test_dev->config_mutex, buf,
>  				    config->test_fs);
>  }
> -static DEVICE_ATTR(config_test_fs, 0644, config_test_fs_show,
> -		   config_test_fs_store);
> +static DEVICE_ATTR_RW(config_test_fs);
>  
>  static int trigger_config_run_type(struct kmod_test_device
> *test_dev,
>  				   enum kmod_test_case test_case,
> @@ -1012,8 +1010,7 @@ static ssize_t config_num_threads_show(struct
> device *dev,
>  
>  	return test_dev_config_show_int(test_dev, buf, config-
> >num_threads);
>  }
> -static DEVICE_ATTR(config_num_threads, 0644,
> config_num_threads_show,
> -		   config_num_threads_store);
> +static DEVICE_ATTR_RW(config_num_threads);
>  
>  static ssize_t config_test_case_store(struct device *dev,
>  				      struct device_attribute *attr,
> @@ -1037,8 +1034,7 @@ static ssize_t config_test_case_show(struct
> device *dev,
>  
>  	return test_dev_config_show_uint(test_dev, buf, config-
> >test_case);
>  }
> -static DEVICE_ATTR(config_test_case, 0644, config_test_case_show,
> -		   config_test_case_store);
> +static DEVICE_ATTR_RW(config_test_case);
>  
>  static ssize_t test_result_show(struct device *dev,
>  				struct device_attribute *attr,
> @@ -1049,7 +1045,7 @@ static ssize_t test_result_show(struct device
> *dev,
>  
>  	return test_dev_config_show_int(test_dev, buf, config-
> >test_result);
>  }
> -static DEVICE_ATTR(test_result, 0644, test_result_show,
> test_result_store);
> +static DEVICE_ATTR_RW(test_result);
>  
>  #define TEST_KMOD_DEV_ATTR(name)		&dev_attr_##name.att
> r
>  
> diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
> index 7a54e3083203..79d4dc785e5c 100644
> --- a/sound/soc/omap/mcbsp.c
> +++ b/sound/soc/omap/mcbsp.c
> @@ -854,7 +854,7 @@ static ssize_t dma_op_mode_store(struct device
> *dev,
>  	return size;
>  }
>  
> -static DEVICE_ATTR(dma_op_mode, 0644, dma_op_mode_show,
> dma_op_mode_store);
> +static DEVICE_ATTR_RW(dma_op_mode);
>  
>  static const struct attribute *additional_attrs[] = {
>  	&dev_attr_max_tx_thres.attr,
> @@ -923,7 +923,7 @@ static ssize_t st_taps_store(struct device *dev,
>  	return size;
>  }
>  
> -static DEVICE_ATTR(st_taps, 0644, st_taps_show, st_taps_store);
> +static DEVICE_ATTR_RW(st_taps);
>  
>  static const struct attribute *sidetone_attrs[] = {
>  	&dev_attr_st_taps.attr,
